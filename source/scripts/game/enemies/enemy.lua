-- This is a very generic parent class that is meant to be extended for every enemy in the game. It implements
-- the most basic components that every enemy would have, which is a state machine, the correct collision groups,
-- and taking damage and flashing when being damaged. This gets extended by basicEnemy.lua

import "scripts/libraries/AnimatedSprite"

local pd <const> = playdate
local gfx <const> = pd.graphics

class('Enemy').extends(AnimatedSprite)

function Enemy:init(x, spritesheet)
    Enemy.super.init(self, spritesheet)
    self:setGroups(ENEMY_GROUP)
    self.collisionResponse = gfx.sprite.kCollisionTypeOverlap
    self:setCenter(0.5, 1.0)
    self:moveTo(x, GROUND_LEVEL)
    self.hitFlashTime = 100
    self.died = false
end

function Enemy:damage(amount)
    local enemyAlive = self.health > 0
    self.health -= amount
    self:setImageDrawMode(gfx.kDrawModeFillWhite)
    pd.timer.new(self.hitFlashTime, function()
        self:setImageDrawMode(gfx.kDrawModeCopy)
    end)
    return enemyAlive
end

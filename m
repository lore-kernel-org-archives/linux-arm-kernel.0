From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 31 Jan 2013 15:37:22 +0000
Subject: [PATCHv5 14/16] ARM: arch_timers: switch to physical timers if
 HYP mode is available
In-Reply-To: <1359634539-9580-15-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
 <1359634539-9580-15-git-send-email-mark.rutland@arm.com>
Message-ID: <20130131153721.GL12877@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 12:15:37PM +0000, Mark Rutland wrote:
> From: Marc Zyngier <Marc.Zyngier@arm.com>
> 
> If we're booted in HYP mode, it is possible that we'll run some
> kind of virtualized environment. In this case, it is a better to
> switch to the physical timers, and leave the virtual timers to
> guests.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

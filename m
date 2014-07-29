From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 29 Jul 2014 13:39:45 +0100
Subject: [PATCH] arm64: Fix UP build warning in gic-v3
In-Reply-To: <20140729120317.GP17528@sirena.org.uk> (Mark Brown's message of
 "Tue, 29 Jul 2014 13:03:17 +0100")
References: <1406588159.28348.41.camel@smoke>
 <878uncml7n.fsf@approximate.cambridge.arm.com>
 <20140729120317.GP17528@sirena.org.uk>
Message-ID: <874my0mj8u.fsf@approximate.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29 2014 at  1:03:17 pm BST, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jul 29, 2014 at 12:57:16PM +0100, Marc Zyngier wrote:
>
>> There is a similar patch from Mark Brown on its way (not addressing
>> gic_write_sgi1r though).
>
> Right, I was thinking that was better fixed by making all those
> access functions static inline instead, I didn't get round to looking at
> that properly yet though so didn't send a patch.  Moving the one
> accessor function felt like it was the wrong way to go but that's just
> taste.

I don't mind either way. As long as no annoying warning is produced, I'm
cool with it.

	M.
-- 
Jazz is not dead. It just smells funny.

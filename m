From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Jun 2013 17:05:49 -0700
Subject: [GIT PULL] ARM: mvebu: fixes for v3.10 (round 4)
In-Reply-To: <20130610203033.GP23859@titan.lakedaemon.net>
References: <20130610203033.GP23859@titan.lakedaemon.net>
Message-ID: <20130612000549.GJ23774@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 04:30:33PM -0400, Jason Cooper wrote:
> Arnd, Olof
> 
> Here are two small fixes I've had in my tree for a few days.  I looked
> at moving one or both of them to fixes-non-critical, but it's not
> appropriate.
> 
>   5f1f3d5 arm: mvebu: armada-xp-{gp,openblocks-ax3-4}: specify PCIe range
> 
> builds on two patches already merged for v3.10 (through mvebu/fixes):
> 
>   c6c003a ARM: mvebu: Fix ranges entry on XP GP board
>   8eed481 arm: mvebu: fix the 'ranges' property to handle PCIe
> 
> 
> And:
> 
>   4089fe9 ARM: Kirkwood: handle mv88f6282 cpu in __kirkwood_variant().
> 
> Is flagged for stable, which according to Linus, is appropriate for this
> stage of the -rc cycle.
> 
> If I've made an error in judgement, please let me know.


Unfortunate that they weren't found sooner, but looks like relevant fixes.

Pulled, thanks.

-Olof

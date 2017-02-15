From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 15 Feb 2017 15:56:03 +0100
Subject: [PATCH] ARM: dts: armada-385-linksys: fix DSA compatible property
In-Reply-To: <20170209155155.GA29882@lunn.ch> (Andrew Lunn's message of "Thu,
 9 Feb 2017 16:51:55 +0100")
References: <20170209152702.23036-1-ralph.sennhauser@gmail.com>
 <20170209155155.GA29882@lunn.ch>
Message-ID: <87r32zcxks.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ralph and Andrew,
 
 On jeu., f?vr. 09 2017, Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Feb 09, 2017 at 04:27:02PM +0100, Ralph Sennhauser wrote:
>> The switch to the new DSA binding used "marvell,mv88e6095" for the
>> compatible property which doesn't exist, use "marvell,mv88e6085"
>> instead.
>> 
>> Fixes: 455b82f03f52 ("ARM: dts: armada-385-linksys: Utilize new DSA binding")
>> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
>
> Hi Ralph
>
> Good catch.
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
> Gregory, this is in the mvebu dt branch and need fixing there.


Applied on mvebu/dt if it can't go through arm-soc I will submitted as a
fix for v4.11-rc1.

Thanks,

Gregory


>
> [Goes away to look at the other dts files]
>
> O.K. Florian only made this typ0 once in the patchset.
>
>      Andrew

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

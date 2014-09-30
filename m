From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 12:22:21 +0200
Subject: [PATCH 0/3] ARM: Meson6: enable SMP
In-Reply-To: <20140930084646.GA31027@carlo-MacBookPro>
References: <1412066635-5298-1-git-send-email-carlo@caione.org>
 <20140930084646.GA31027@carlo-MacBookPro>
Message-ID: <2970330.BJMVixgoJ1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 September 2014 10:46:46 Carlo Caione wrote:
> On mar, set 30, 2014 at 10:43:52 +0200, Carlo Caione wrote:
> > Amlogic Meson6 is a dual-core Cortex-A9. This patchset adds all the necessary
> > pieces to boot the secondary CPU.
> 
> Sorry for the double sending.
> Forgot to CC LAKML.

Looks good to me in principle, but I wonder about the CPU enable method.
Are you able to implement PSCI in u-boot like it was done for allwinner?

This is mostly a question of whether the system comes up in secure mode
or non-secure mode.

	Arnd

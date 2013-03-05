From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 05 Mar 2013 19:23:23 +0100
Subject: [PATCH] ARM: dove: Fix typo "COMMON_CLK_DOVE"
In-Reply-To: <20130305190232.0b1a5e29@armhf>
References: <1362476098.16460.65.camel@x61.thuisdomein>
 <20130305140025.GO23237@titan.lakedaemon.net>
 <20130305190232.0b1a5e29@armhf>
Message-ID: <1362507803.16460.100.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-03-05 at 19:02 +0100, Jean-Francois Moine wrote:
> The .config contains CONFIG_COMMON_CLK=y naturally because MACH_DOVE
> selects PLAT_ORION_LEGACY which selects PLAT_ORION which selects
> COMMON_CLK.
> 
> So, "select COMMON_CLK" is not needed in ARCH_DOVE.

Thanks. Unless people object (because they prefer an explicit, though
superfluous, select of COMMON_CLK) I'll redo my patch.


Paul Bolle

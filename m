From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 20 Dec 2013 11:23:39 +0800
Subject: [PATCH V2] ARM: dts: imx6qdl-sabresd: Add power key support
In-Reply-To: <276922cfe7a844c3b7f9f7c18bf86f77@BY2PR03MB315.namprd03.prod.outlook.com>
References: <1387487244-2749-1-git-send-email-b20788@freescale.com>
 <20131220022821.GJ7172@S2101-09.ap.freescale.net>
 <276922cfe7a844c3b7f9f7c18bf86f77@BY2PR03MB315.namprd03.prod.outlook.com>
Message-ID: <20131220032334.GL7172@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 03:00:48AM +0000, Anson.Huang at freescale.com wrote:
> >+193,16 @@
> >>  			>;
> >>  		};
> >>  	};
> >> +
> >> +	gpio-keys {
> >
> >We now use one pinctrl container 'imx6qdl-sabresd' for all pinctrl groups, so
> >we can move pinctrl_gpio_keys into above and save this gpio-keys container.
> >
> 
> Understood, thanks, just put this group in the hog node, no need to add a new gpio-keys.

What I meant is something below.

https://git.linaro.org/people/shawn.guo/linux-2.6.git/commitdiff/811c64db0af086314ef4e5e4ae22ed157265f3cb

Shawn

From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 15 Dec 2015 22:47:09 +0800
Subject: [PATCH] arm64: dts: berlin4ct: switch to Cortex-A53 specific
 pmu nodes
In-Reply-To: <8261316.NuheDtlQ6N@wuerfel>
References: <1450190172-1161-1-git-send-email-jszhang@marvell.com>
 <8261316.NuheDtlQ6N@wuerfel>
Message-ID: <20151215224709.2d71d2ba@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd,

On Tue, 15 Dec 2015 15:43:53 +0100 Arnd Bergmann wrote:

> On Tuesday 15 December 2015 22:36:12 Jisheng Zhang wrote:
> > -               compatible = "arm,armv8-pmuv3";
> > +               compatible = "arm,cortex-a53-pmu";
> >   
> 
> Should this list both?

IMHO, we don't need to list both. The pmu binding document also says:
"compatible : should be one of ...."

Dear Mark,

Could you please give suggestions?

Thanks,
Jisheng

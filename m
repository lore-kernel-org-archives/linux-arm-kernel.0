From: zhengyu.shen@nxp.com (Zhengyu Shen)
Date: Wed, 17 Aug 2016 15:31:19 +0000
Subject: [PATCH v2] Added perf functionality to mmdc driver
In-Reply-To: <1471395561-30389-1-git-send-email-Nitin.Chaudhary@zii.aero>
References: <20160815223035.5429-1-zhengyu.shen@nxp.com>
 <1471395561-30389-1-git-send-email-Nitin.Chaudhary@zii.aero>
Message-ID: <DB5PR04MB1430018C7BFB14A65517162C9F140@DB5PR04MB1430.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The following series of patch resolve the kernel compilation errors with the
> proposed perf functionality integration into MMDC driver by Zhengyu Shen.
> These provide the working code which can be enhanced upon as per the
> reviews from Mark and Peter but will make sure that code compiles without
> errors and still retains working as was proposed by Zhengyu. I suggest further
> improvements from review comments could be done on top of it from
> further on with this being used as a base.
> 
> Nitin Chaudhary (2):
>   Error: Fix mmdc compilation errors due to cpu notifier
>   [i.MX6Q] Code cleanup & verification after fixing compilation error
> 
>  arch/arm/mach-imx/mmdc.c   | 95 ++++++++++++++++++++++++------------
> ----------
>  include/linux/cpuhotplug.h |  1 +
>  2 files changed, 50 insertions(+), 46 deletions(-)
> 
> --
> 2.7.4

Hi, thanks for the help. Is it impossible for two pmus to be created? I wasn't sure
about that, which is why I didn't have pmu_mmdc set to static.  

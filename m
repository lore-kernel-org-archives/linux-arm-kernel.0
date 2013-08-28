From: afzal@ti.com (Afzal Mohammed)
Date: Wed, 28 Aug 2013 17:39:13 +0530
Subject: [PATCH v2 00/13] ARM: OMAP2+: AM43x PRCM support
In-Reply-To: <52133482.7080405@baylibre.com>
References: <cover.1375443858.git.afzal@ti.com>
 <20130813080159.GT7656@atomide.com> <5211BD07.9090309@ti.com>
 <52133482.7080405@baylibre.com>
Message-ID: <521DE869.6020503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On Tuesday 20 August 2013 02:48 PM, Benoit Cousson wrote:

> Otherwise, I guess that most of these patches should be non-intrusive
> for other OMAPs beside that one (ARM: OMAP2+: CM: reintroduce SW_SLEEP
> for OMAP4). And for the moment, that's maybe the most important point.
> 
> Have you checked that it will not generate any regression for OMAP4 in
> term of PM features: suspend, cpuidle at least?

As noted by Rajendra, there could problem where clockdomain doesn't have
SW_SLEEP and only have HW_AUTO. I have to rework the relevant patch to
handle it properly.

Regards
Afzal

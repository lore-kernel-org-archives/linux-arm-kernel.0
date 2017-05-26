From: tony@atomide.com (Tony Lindgren)
Date: Fri, 26 May 2017 08:30:46 -0700
Subject: [PATCH v2 1/2] ARM: dts: am335x-sl50: Fix card detect pin for mmc1
In-Reply-To: <20170522090153.5596-1-enric.balletbo@collabora.com>
References: <20170522090153.5596-1-enric.balletbo@collabora.com>
Message-ID: <20170526153045.GA3717@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enric Balletbo i Serra <enric.balletbo@collabora.com> [170522 02:05]:
> The second version of the hardware moved the card detect pin from gpio0_6
> to gpio1_9, as we won't support the first hardware version fix the pinmux
> configuration of this pin.

OK so proto vs production version misconfiguration, applying both into
omap-for-v4.12/fixes-v2 thanks. Note that you're not supposed to send
any email to the stable list unless requesting a backport of something.
The idea is to add the stable tag when committing, and nowadays it seems
having a proper "Fixes" tag seems to do the job automatically.

Regards,

Tony

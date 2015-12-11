From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 11 Dec 2015 12:33:24 +0100
Subject: [PATCH 1/3] ARM: dts: rockchip: correct the name of REG8 for
 rk3288-evb-act8846
In-Reply-To: <1449726399-12507-1-git-send-email-zyw@rock-chips.com>
References: <1449726399-12507-1-git-send-email-zyw@rock-chips.com>
Message-ID: <5012918.BpMjH3m3af@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris

Am Donnerstag, 10. Dezember 2015, 13:46:37 schrieb Chris Zhong:
> According to the schematic, the name of REG8 should be vcc_tp, rather
> than vcca_tp.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>

applied all 3 to my dts32 branch for 4.5
[after making ARM in patch3 upper case ;-) ]


Thanks for keeping both board variants in sync
Heiko

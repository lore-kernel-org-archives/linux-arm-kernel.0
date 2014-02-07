From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 07 Feb 2014 11:04:30 +0100
Subject: [GIT PULL] ARM: imx: device tree changes for 3.15, take 1
In-Reply-To: <20140205122258.GA13821@S2101-09.ap.freescale.net>
References: <20140205122258.GA13821@S2101-09.ap.freescale.net>
Message-ID: <4771497.sfdTTRjnSv@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Am Mittwoch, 5. Februar 2014, 20:23:01 schrieb Shawn Guo:
>  - Make pinctrl nodes board specific to avoid floating board specific
>    device tree blob with so many unused pinctrl data.

can you take a look at "dtc: add ability to make nodes conditional on them 
being referenced" [0] to see if it can help to solve the floating pinctrl 
problem more generic in the future?


Heiko


[0] http://www.spinics.net/lists/arm-kernel/msg303967.html

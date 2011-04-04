From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 3 Apr 2011 23:37:03 -0300
Subject: [PATCH 1/3] ARM: mx5/mx53_loco: Add write-protect and card-detect
	for SD3
In-Reply-To: <20110404000125.GA19849@pengutronix.de>
References: <1301686188-14827-1-git-send-email-fabio.estevam@freescale.com>
	<4D99028D.4000808@freescale.com>
	<20110404000125.GA19849@pengutronix.de>
Message-ID: <BANLkTi=ZG7Q220aT8m7A1=UU16PWRwxgSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Sun, Apr 3, 2011 at 9:01 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> Hi Fabio,
>
>> mmcblk1: error -84 transferring data, sector 32769, nr 32, card status 0x900
>
> Last time I had -EILSEQ, the buswidth-caps were wrong. Does the board support
> 8bit-width?

Yes, esdhc3 port on mx53_loco board supports 8-bit width.

Regards,

Fabio Estevam

From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 17 Dec 2014 08:58:23 +0100
Subject: [PATCH RFC] clk: mxs: Fix invalid 32-bit access to frac registers
In-Reply-To: <CAOMZO5CQjpYtrNTT65-ikJua4N_osYj4UVgm3EV+sEvVWF59cg@mail.gmail.com>
References: <1418570933-21585-1-git-send-email-stefan.wahren@i2se.com>	<201412141712.12589.marex@denx.de>	<1638147247.144508.1418577377536.JavaMail.open-xchange@oxbaltgw03.schlund.de>
 <CAOMZO5CQjpYtrNTT65-ikJua4N_osYj4UVgm3EV+sEvVWF59cg@mail.gmail.com>
Message-ID: <5491379F.3090607@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Am 17.12.2014 um 03:44 schrieb Fabio Estevam:
> Hi Stefan,
>
> On Sun, Dec 14, 2014 at 3:16 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
>> Btw i hope this patch also fixes a SPI communication issue with our hardware
>> which forces us to bypass ref_io1 for ssp2.
> Does this patch fix the SPI issue?

unfortunately not. If the 3.19-rc1 has been released, i send the fixed
patch.

I've the theory that's an initialization issue. I've never heard of SPI
problems from the U-Boot users and we are using imx-bootlets.

I'll try to test it with U-Boot.

Stefan

From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Fri, 17 Jan 2014 03:02:11 +0000
Subject: [PATCH V7 1/3] ARM: imx: add suspend in ocram support for i.mx6q
In-Reply-To: <20140117021320.GA1565@shlinux1.ap.freescale.net>
References: <1389864907-4040-1-git-send-email-b20788@freescale.com>
 <20140117021320.GA1565@shlinux1.ap.freescale.net>
Message-ID: <3b93c934048347b7b3a7525e8d662c83@BY2PR03MB315.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Shawn
	Yes, this can be __initconst, I found that just after I sent out the patch set:), will do it in V8.

Best Regards.
Anson huang ???
?
Freescale Semiconductor Shanghai
?????????192?A?2?
201203
Tel:021-28937058


>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at linaro.org]
>Sent: Friday, January 17, 2014 10:13 AM
>To: Huang Yongcai-B20788
>Cc: kernel at pengutronix.de; linux at arm.linux.org.uk; linux-arm-
>kernel at lists.infradead.org
>Subject: Re: [PATCH V7 1/3] ARM: imx: add suspend in ocram support for i.mx6q
>
>On Thu, Jan 16, 2014 at 05:35:05PM +0800, Anson Huang wrote:
>> +static const u32 imx6q_mmdc_io_offset[] = {
>
>This can be __initconst?
>
>Shawn
>
>> +	0x5ac, 0x5b4, 0x528, 0x520, /* DQM0 ~ DQM3 */
>> +	0x514, 0x510, 0x5bc, 0x5c4, /* DQM4 ~ DQM7 */
>> +	0x56c, 0x578, 0x588, 0x594, /* CAS, RAS, SDCLK_0, SDCLK_1 */
>> +	0x5a8, 0x5b0, 0x524, 0x51c, /* SDQS0 ~ SDQS3 */
>> +	0x518, 0x50c, 0x5b8, 0x5c0, /* SDQS4 ~ SDQS7 */
>> +	0x784, 0x788, 0x794, 0x79c, /* GPR_B0DS ~ GPR_B3DS */
>> +	0x7a0, 0x7a4, 0x7a8, 0x748, /* GPR_B4DS ~ GPR_B7DS */
>> +	0x59c, 0x5a0, 0x750, 0x774, /* SODT0, SODT1, MODE_CTL, MODE */
>> +	0x74c,			    /* GPR_ADDS */
>> +};

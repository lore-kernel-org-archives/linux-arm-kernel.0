From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 13 Jul 2011 19:13:10 +0800
Subject: [alsa-devel] [PATCH V2 04/10] ASoc: mxs: add asoc configuration
	files
In-Reply-To: <20110713090819.GB1928@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-5-git-send-email-b29396@freescale.com>
	<20110713090819.GB1928@pengutronix.de>
Message-ID: <CAA+hA=QEWMqc12wGz6M7ejtVmB3Wx2Wc2wNXyq78QrPrW8qE1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/13 Wolfram Sang <w.sang@pengutronix.de>:
>> +if SND_MXS_SOC
>> +
>> +config SND_SOC_MXS_SGTL5000
>> + ? ? tristate "SoC Audio support for i.MX boards with sgtl5000"
>
> depends on I2C
Added.
Thanks.

Regards
Dong Aisheng

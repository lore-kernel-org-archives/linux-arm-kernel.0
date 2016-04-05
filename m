From: harninder.rai@nxp.com (Harninder Rai)
Date: Tue, 5 Apr 2016 10:42:58 +0000
Subject: Help needed with kexec on arm64
In-Reply-To: <20160405052341.GA19476@linaro.org>
References: <DB5PR04MB168845795D86B4CE5BA5656FE68B0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <1458230896.3391.18.camel@infradead.org>
 <CAB5YjtBEO=efjhcFdVOaZqG13qK3uzCbS5SFym5hhw-n+_QLhw@mail.gmail.com>
 <DB5PR04MB1688A6D4385B76DAFF71D364E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtAqjL8LMvNPbxwVWe+Zhi5rFkz_X7rti9wSrXQ7Y_2kOA@mail.gmail.com>
 <DB5PR04MB16880834700413C3B80194B5E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtCP6M9=ESJhfxyyYKSGTg8s3Y83qp8RS_oyYkUqcqYcCw@mail.gmail.com>
 <DB5PR04MB168874758924173BBD5CC037E69D0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <20160405052341.GA19476@linaro.org>
Message-ID: <HE1PR04MB169039A2FC3CAA56A67CD4A6E69E0@HE1PR04MB1690.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This means that there is no enough space left at this point.
> I guess that you are using too big initramfs against 64MB of total memory.
> Just increase the memory size for crash dump kernel.

Thanks Takahiro. Let me try either with small initramfs or increase memory size for crash dump kernel


Thanks and Regards
Harry++

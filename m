From: harninder.rai@nxp.com (Harninder Rai)
Date: Wed, 11 May 2016 11:06:45 +0000
Subject: Help needed with kexec on arm64
In-Reply-To: <20160511005334.GA8417@linaro.org>
References: <DB5PR04MB168845795D86B4CE5BA5656FE68B0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <1458230896.3391.18.camel@infradead.org>
 <CAB5YjtBEO=efjhcFdVOaZqG13qK3uzCbS5SFym5hhw-n+_QLhw@mail.gmail.com>
 <DB5PR04MB1688A6D4385B76DAFF71D364E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtAqjL8LMvNPbxwVWe+Zhi5rFkz_X7rti9wSrXQ7Y_2kOA@mail.gmail.com>
 <DB5PR04MB16880834700413C3B80194B5E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtCP6M9=ESJhfxyyYKSGTg8s3Y83qp8RS_oyYkUqcqYcCw@mail.gmail.com>
 <DB5PR04MB168874758924173BBD5CC037E69D0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <20160405052341.GA19476@linaro.org>
 <DB5PR04MB1688F09062B2A5ECACCA4D80E6710@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <20160511005334.GA8417@linaro.org>
Message-ID: <DB5PR04MB1688F1ECCB23EC3A2D76D5B7E6720@DB5PR04MB1688.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Takahiro Akashi,

> >
> > I used a smaller initramfs (as you suggested) and my crash kernel has
> moved further but it again dumped with the following log messages. Any
> further pointers?
> 
> It seems that you have already reached the point of kicking up "init"
> process, and this means that crash dump kernel itself successfully booted.
Yes, I too thought the same
> 
> > Does this mean that there isn't enough memory to save the core file or
> > something? Because the error mostly are related to OOM killer process
> 
> Apparently lack of memory is a cause of OOM killer, but the core file has
> nothing to do with this issue.
> I think that you don't have enough memory for the system yet.
Looks like there's only few MBs space left on my rootfs. Let me try shifting to secondary storage for storing the rootfs or maybe use chroot

Once again, thanks for the help

Regards
Harry++

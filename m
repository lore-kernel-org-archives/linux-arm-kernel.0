From: geoff@infradead.org (Geoff Levand)
Date: Fri, 27 May 2016 12:19:45 -0700
Subject: Help needed with kexec on arm64
In-Reply-To: <20160527135820.GM19428@n2100.arm.linux.org.uk>
References: <CAB5YjtAqjL8LMvNPbxwVWe+Zhi5rFkz_X7rti9wSrXQ7Y_2kOA@mail.gmail.com>
 <DB5PR04MB16880834700413C3B80194B5E68C0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <CAB5YjtCP6M9=ESJhfxyyYKSGTg8s3Y83qp8RS_oyYkUqcqYcCw@mail.gmail.com>
 <DB5PR04MB168874758924173BBD5CC037E69D0@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <20160405052341.GA19476@linaro.org>
 <DB5PR04MB1688F09062B2A5ECACCA4D80E6710@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <20160511005334.GA8417@linaro.org>
 <DB5PR04MB1688C3F122091109E6BD9B68E6740@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <20160519110307.GA4941@linaro.org>
 <DB5PR04MB16887FF10CEA6AA9BF990F0DE6420@DB5PR04MB1688.eurprd04.prod.outlook.com>
 <20160527135820.GM19428@n2100.arm.linux.org.uk>
Message-ID: <1464376785.12343.3.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-05-27 at 14:58 +0100, Russell King - ARM Linux wrote:
> On Fri, May 27, 2016 at 11:51:03AM +0000, Harninder Rai wrote:Hello Takahiro Akashi,
> > 
> > Please see the following log which I was talking about in my last communication
> > Any idea as to what could be wrong just when I move from RAM based rootfs to SD based rootfs?

> debug output... if the architecture is usefully printing stuff like
> memory layouts etc.
You should be able to get more information by using kexec -d to enable

Also, use the latest from here:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/kexec-tools.git
  
-Geoff

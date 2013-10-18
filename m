From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 18 Oct 2013 09:49:15 -0700
Subject: [BUILD BROKEN] Current Linus' master and -next don't build for
 imx_v6_v7_defconfig
In-Reply-To: <CAGa+x86+qfWBou2jkEjz10ix95m89cxnyyFOPwryF27YezeoPw@mail.gmail.com>
References: <Pine.LNX.4.64.1310181632160.9158@axis700.grange>
 <CAGa+x86+qfWBou2jkEjz10ix95m89cxnyyFOPwryF27YezeoPw@mail.gmail.com>
Message-ID: <20131018164915.GA29015@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 08:14:36AM -0700, Kevin Hilman wrote:
> On Fri, Oct 18, 2013 at 7:59 AM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> 
> > On current Linus' tree as of 04919af as well as -next since 16.10, IIRC,
> > compilation is broken for i.MX3*, including the default
> > imx_v6_v7_defconfig. The toolchain used is
> >
> > arm-none-linux-gnueabi-gcc (Sourcery CodeBench Lite 2012.09-64) 4.7.2
> 
> Just for another data point, I'm not seeing this in my builds
> (arm-linux-gnueabi-gcc (Ubuntu/Linaro 4.7.2-1ubuntu1) 4.7.2) and we're
> not seeing this in Olof's autobuilds either for latest mainline[1] or
> latest next-thierry[2].  I belive Olof is using vanilla gcc 4.8.1.
> 
> Kevin
> 
I don't see the problem either, using "arm-poky-linux-gnueabi-gcc (GCC) 4.7.2"
from Yocto 1.4.2.

Guenter

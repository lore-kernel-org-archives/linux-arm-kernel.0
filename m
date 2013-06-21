From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 22 Jun 2013 01:24:40 +0200
Subject: [PATCH] ARM: imx: select syscon for IMX6L
In-Reply-To: <CAOMZO5A++=N4BE24DBqat71HTMgEHVG3zn_GZEjYbw5K+6VP7g@mail.gmail.com>
References: <201306220039.43988.arnd@arndb.de>
 <CAOMZO5A++=N4BE24DBqat71HTMgEHVG3zn_GZEjYbw5K+6VP7g@mail.gmail.com>
Message-ID: <201306220124.40831.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 22 June 2013, Fabio Estevam wrote:
> On Fri, Jun 21, 2013 at 7:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > This is required for building a kernel that enables only
> > IMX6L but not IMX6Q, which would get a build error when
> 
> I think you mean IMX6SL.

Right. I fixed up my local copy of the patch now.

	Arnd

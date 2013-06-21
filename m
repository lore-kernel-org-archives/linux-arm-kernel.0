From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 21 Jun 2013 19:43:26 -0300
Subject: [PATCH] ARM: imx: select syscon for IMX6L
In-Reply-To: <201306220039.43988.arnd@arndb.de>
References: <201306220039.43988.arnd@arndb.de>
Message-ID: <CAOMZO5A++=N4BE24DBqat71HTMgEHVG3zn_GZEjYbw5K+6VP7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 7:39 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> This is required for building a kernel that enables only
> IMX6L but not IMX6Q, which would get a build error when

I think you mean IMX6SL.

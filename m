From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 2 Mar 2015 22:30:58 +0100
Subject: [PATCH 0/5] ARM: orion5k/mv78xx0/dove multiplatform support
In-Reply-To: <1425328618-894030-1-git-send-email-arnd@arndb.de>
References: <1425328618-894030-1-git-send-email-arnd@arndb.de>
Message-ID: <20150302213058.GB2375@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 09:36:53PM +0100, Arnd Bergmann wrote:
> Hi everyone,

Hi Arnd

Dove already is multi-platform, when you use it in mach-mvebu.  The
old mach-dove is there to slowly bit rot, because there is one user
who has a lot of out of tree patches which are apparently not easy to
make work with DT mach-mvebu Dove code.

> I'm trying to get all ARMv7 platforms moved over to
> ARCH_MULTIPLATFORM

It should be noted that orion5x is not an ARMv7.

   Andrew

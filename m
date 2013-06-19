From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Jun 2013 20:46:40 +0200
Subject: [PATCH RFC 0/2] Extend multi_v7_defconfig
In-Reply-To: <1371664384-24974-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1371664384-24974-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <201306192046.41005.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013, Soren Brinkmann wrote:
> I don't know how much a defconfig is supposed to provide, hence as RFC.
> This patches are needed for booting Zynq into a minimum ramfs based
> system with a serial console.

In my opinion we should provide enable all the platform specific drivers
in the defconfigs, as well as everything needed to boot the system,
to get proper compile coverage as well as the ability to test changes
easily. Your patches look good. Michal, would you apply them and
send another pull request or should I just take them directly?

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Nov 2013 13:32:58 +0100
Subject: [PATCH v2] ARM: remove name from machine_desc for DT platforms
In-Reply-To: <5283DB34.9050301@gmail.com>
References: <1383511801-31682-1-git-send-email-robherring2@gmail.com>
 <CAOesGMg7Mt+p8U7Z5sLQDqoFG-QEUi94Vt=pxXM0NqyefBLxVA@mail.gmail.com>
 <5283DB34.9050301@gmail.com>
Message-ID: <201311141332.58498.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 November 2013, Rob Herring wrote:
> I'm not inclined to expand cpuinfo and prior attempts to add more info
> to cpuinfo like SoC name have failed. The differences between x86 and
> arm cpuinfo already cause issues for arm. lscpu does not really work on arm.

Well, they turned into drivers/base/soc.c, which adds the information in
a structured way in sysfs, but is only used on a couple of platforms.

> I'd actually prefer If you really want more system info, then go read
> /proc/device-tree.

Good point.

	Arnd

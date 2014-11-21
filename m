From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Fri, 21 Nov 2014 14:30:01 +0100
Subject: [PATCH] ARM: tegra: colibri t30: fix on-module ethernet
In-Reply-To: <1416571072.2744.4.camel@localhost.localdomain>
References: <b1cdc96ce8bb15059d7eea282f6586a826bee124.1416566157.git.marcel@ziswiler.com>
 <1416571072.2744.4.camel@localhost.localdomain>
Message-ID: <1416576601.2744.11.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-11-21 at 12:57 +0100, Marcel Ziswiler wrote:
> Doing automatic power-cycle tests revealed that this is still not enough
> and a proper reset-cycle might be required. However I don't know as of
> yet how one can easily do that in mainline with a USB device otherwise
> not mentioned anywhere in the device tree. Any ideas?

OK, looks like I need something as follows just wondering how far it can
go (e.g. not even in -next as of yet):

http://thread.gmane.org/gmane.linux.kernel/1682436

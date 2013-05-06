From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 6 May 2013 14:52:25 +0200
Subject: MVEBU PCI Express support
In-Reply-To: <5183F858.1050804@itooo.com>
References: <5183F858.1050804@itooo.com>
Message-ID: <20130506145225.67d04859@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Greg,

On Fri, 03 May 2013 19:48:08 +0200, Greg wrote:

> this one is targeted to the Free Electrons guys : should I start 
> investigating by myself or are you planning to release a patch for 
> supporting PCI express on Marvell Armada* platforms ?

We have already posted 8 versions of the PCIe patches on this list. The
last version is
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/161968.html.
However, this patch set has a few dependencies, so if you want
something ready-to-use even if not yet in mainline, I would recommend
you to have a look at
https://github.com/MISL-EBU-System-SW/mainline-public/tree/backport-3.8.
This is a 3.8 vanilla kernel into which we have backported a number of
features/fixes, including the PCIe support.

We're hoping to get PCIe support in mainline for 3.11.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Feb 2016 16:54:12 -0800
Subject: [PATCH v6] Fix sun7i pin assignment for IRQ's
In-Reply-To: <1456161251-2303-1-git-send-email-henry@nitronetworks.nl>
References: <1456161251-2303-1-git-send-email-henry@nitronetworks.nl>
Message-ID: <20160225005412.GB4736@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Usually, the patch title should be prefixed by the subsystem it
applies to so that maintainer and reviewers can spot it more
easily. In this case, it would be something like

pinctrl: sunxi: Fix sun7i pin assignment for IRQ's

On Mon, Feb 22, 2016 at 06:14:07PM +0100, Henry Paulissen wrote:
> After testing IRQ pins we found some bugs in the pinctrl declaration.
> Both PI* and PC* pins didn't work. PI* pins seemed to be connected
> to the wrong mux and PC* pins waren't working at all.
> 
> Please note that the A20 soc manual is contradicting between version
> and even within the same document for both the PI and PC pins.

Which sections are in contradiction?

> Patch is based on testing with the hardware itself.

How did you test it? Using the sysfs API, or did you have any hardware
connected to it?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160224/8bfcd770/attachment.sig>

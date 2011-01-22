From: lool@dooz.org (=?iso-8859-1?Q?Lo=EFc?= Minier)
Date: Sun, 23 Jan 2011 00:15:46 +0100
Subject: Linux ARM SMP kernel for qemu
In-Reply-To: <AANLkTim4UTckvZeokXy9jhzyvw0NXZTjbE8w6cGvy02d@mail.gmail.com>
References: <AANLkTimi5B8pBVatpq4n2HvcT-iU6+EXwdntV1ucAkVL@mail.gmail.com>
	<AANLkTim4UTckvZeokXy9jhzyvw0NXZTjbE8w6cGvy02d@mail.gmail.com>
Message-ID: <20110122231546.GG11630@bee.dooz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 21, 2011, Kevin Pouget wrote:
> do you know if it's feasible to compile a Linux kernel to be run by a Qemu
> SMP ARM machine? after so many hours of tries, I can say that any version of
> the kernel, any Qemu machine would be okay, provided that the SMP capability
> is set, and the kernel boots !

 I apologize for the old references, but I wondered the same a while ago
 and managed to get a SMP Realview EB kernel booted in QEMU IIRC.  I
 think it was only armv6 SMP back then.  Main issue I had back then was
 that it wouldn't support PCI so no networking or IDE.  My notes are at:
 https://lists.ubuntu.com/archives/ubuntu-mobile/2009-May/002485.html
 (some other related message same month and next month)

 I would myself love hearing what you manage to achieve, with which
 configs and issues!

-- 
Lo?c Minier

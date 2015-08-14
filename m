From: p.fedin@samsung.com (Pavel Fedin)
Date: Fri, 14 Aug 2015 16:44:24 +0300
Subject: [PATCH v4 1/3] PCI: generic: remove dependency on hw_pci
In-Reply-To: <20150812090449.GA22485@arm.com>
References: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
 <20150804234956.GF17327@google.com>
 <007501d0d4ce$1d2dd9c0$57898d40$@samsung.com> <20150812090449.GA22485@arm.com>
Message-ID: <019001d0d697$55a5cf40$00f16dc0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> >  I also added MSI support. Can i post it as patch on top of your branch?
> 
> There shouldn't be any need with the changes queued in tip/irq/core. Can
> you give the following branch a go, please (it doesn't look like Bjorn's
> stuff is in linux-next, unfortunately)?
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git devel

 I have checked, they already implemented generic handling for "msi-parent" property in the device
tree, and MSI works out of the box.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia

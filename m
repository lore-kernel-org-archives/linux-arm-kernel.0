From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Aug 2015 10:04:50 +0100
Subject: [PATCH v4 1/3] PCI: generic: remove dependency on hw_pci
In-Reply-To: <007501d0d4ce$1d2dd9c0$57898d40$@samsung.com>
References: <1438721620-15493-1-git-send-email-jchandra@broadcom.com>
 <20150804234956.GF17327@google.com>
 <007501d0d4ce$1d2dd9c0$57898d40$@samsung.com>
Message-ID: <20150812090449.GA22485@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 08:11:29AM +0100, Pavel Fedin wrote:
>  Hello!

Hi Pavel,

> > I dropped the acks and tested-by because of that change, but I'll happily
> > add them back if Lorenzo and Pavel confirm.  
> 
>  Confirm.
>  Tested-by: Pavel Fedin <p.fedin@samsung.com>
> 
>  I also added MSI support. Can i post it as patch on top of your branch?

There shouldn't be any need with the changes queued in tip/irq/core. Can
you give the following branch a go, please (it doesn't look like Bjorn's
stuff is in linux-next, unfortunately)?

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git devel

It's a temporary testing branch (subject to rebasing), but it should be
indicative of what's queued for 4.3.

Will

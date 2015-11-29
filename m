From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Nov 2015 00:15:19 +0100
Subject: Adding VIRTIO to the multi_v7_defconfig
In-Reply-To: <CAPokK=rj4dDfMAF16RhY8pnnXrmddtnTyOOB__Eek0GhsC5XeA@mail.gmail.com>
References: <CAPokK=rMi0OuqwePNkWMEi+5f_GZzw-j8fkN__2docvzwGV5+A@mail.gmail.com>
 <2788112.C4O6ljO5dG@wuerfel>
 <CAPokK=rj4dDfMAF16RhY8pnnXrmddtnTyOOB__Eek0GhsC5XeA@mail.gmail.com>
Message-ID: <2508342.e298Q4OUuz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 29 November 2015 14:56:53 Peter Crosthwaite wrote:
> 
> So minimally I am looking for:
> 
> CONFIG_VIRTIO_PCI=y"
> CONFIG_VIRTIO_BLK=y"
> CONFIG_VIRTIO_NET=y"
> 
> As that gets you booted with network without needing initrd. I guess
> the rest of VIRTIO makes more sense as modules as follow up work?

Sounds reasonable to me, though we could debate about VIRTIO_NET.
If nobody else objects, just make it built-in.

	Arnd

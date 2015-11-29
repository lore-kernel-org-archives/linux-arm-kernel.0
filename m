From: crosthwaitepeter@gmail.com (Peter Crosthwaite)
Date: Sun, 29 Nov 2015 14:18:24 -0800
Subject: Adding VIRTIO to the multi_v7_defconfig
Message-ID: <CAPokK=rMi0OuqwePNkWMEi+5f_GZzw-j8fkN__2docvzwGV5+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I started a small project to test as many QEMU emulated ARM boards
using the multi_v7 defconfig:

https://lists.gnu.org/archive/html/qemu-devel/2015-10/msg00755.html

One thing that came up was we cannot use the virt board as it relies
on virtio hotplug and drivers to get block and network support. The
defconfig is missing the drivers. Should we add the VIRTIO drivers to
the defconfig to bring this into play?

Regards,
Peter

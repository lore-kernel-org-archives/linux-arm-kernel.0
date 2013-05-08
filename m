From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Wed, 8 May 2013 15:29:49 -0700
Subject: Problems while booting a linux system on fast models based
 CortexA15
In-Reply-To: <CAJ30i6HzvaKrKha7aVcR50=-5zmgivY-82J6NTqFw7Fh+sNzfQ@mail.gmail.com>
References: <CAJ30i6HzvaKrKha7aVcR50=-5zmgivY-82J6NTqFw7Fh+sNzfQ@mail.gmail.com>
Message-ID: <CAEDV+gLekd9PrX=YqFpKQyLxFHDuAV8F5NvaMkRKZQvR3q_yNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 8, 2013 at 12:07 AM, Mai Daftedar <mai.daftedar@gmail.com> wrote:
> Dear All,
>  I am facing a problem with booting a fully working Linux system on the Fast
> Models based Cortex-A15 simulation platform.
>
> I'm using the "KVM on ARM guide" to configure KVM on the ARM fast models
> with CortexA15, however I get the following kernel panic error  when I use
> NFS to boot the kernel.
>
> VFS: Unable to mount root fs via NFS, trying floppy.
>
> Noting that the kernel semi-hosting arguments used are as follows:
> kernel uImage --fdt host-a15.dtb -- earlyprintk console=ttyAMA0 mem=2048M
> root=/dev/nfs nfsroot=192.168.x.x:/srv/nfsroot/ rw ip=dhcp
>
> Where can I be going wrong?
>
Is that literally the command line you use?

You may want to change those x's then to the actual IP address of your
host machine :)

You also need to make sure that your host machine has NFS configured properly.

-Christoffer

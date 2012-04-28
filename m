From: omycle@gmail.com (Li Haifeng)
Date: Sat, 28 Apr 2012 14:37:14 +0800
Subject: PCI Bus error 6290
Message-ID: <CAFNq8R5QQ8UR7Cus-PGNZT-qhx_W5-jnSi9MvHvfHXkp0sVX+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now I am doing porting Kernel v3.3 on a new arm hardware platform. And
Kernel v3.0.8 works well on this platform.

When the nfs mounted as root fs, the console keep getting floodded
with the message:

"8139too 0000:00:0a.0: eth0: PCI BUS error 6290"

If I used initrd rootfs instead of NFS, the system boot up
successfully. But if I try to ping other ip address, the error message
 also floods the console.

Can anybody give me some suggestion?

Best Regards,
Haifeng Li

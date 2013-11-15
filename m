From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 16 Nov 2013 00:03:23 +0300
Subject: [PATCH v2 3/3] ARM: shmobile: Koelsch: enable Ether in defconfig
In-Reply-To: <20131115052919.GA16854@verge.net.au>
References: <201311150217.23563.sergei.shtylyov@cogentembedded.com>
 <201311150223.40632.sergei.shtylyov@cogentembedded.com>
 <20131115052919.GA16854@verge.net.au>
Message-ID: <52868C1B.2080505@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/15/2013 08:29 AM, Simon Horman wrote:

>> Enable the Ether driver in 'koelsch_defconfig' along with DHCP autoconfiguration
>> and NFS root.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Thanks.

> I think it is also appropriate to remove these too.
> To be hones their inclusion appears to have been an error on my part.
> And if nfsroot is being enabled it seems to be a good opportunity
> to get rid of them.

> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE="../../initramfs/out/rootfs.arm.cpio"
> CONFIG_INITRAMFS_COMPRESSION_GZIP=y

    Hm, where are you seeing these? Tag renesas-devel-v3.12-20131112 doesn't 
contain anything similar...

WBR, Sergei

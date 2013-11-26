From: axel.lin@ingics.com (Axel Lin)
Date: Tue, 26 Nov 2013 08:46:09 +0800
Subject: ARM: nommu: Boot hang after VFS: Mounted root (ext2 filesystem)
 on device 1:0.
In-Reply-To: <20131125194256.GC28642@pengutronix.de>
References: <1385393160.4753.4.camel@phoenix>
 <20131125194256.GC28642@pengutronix.de>
Message-ID: <CAFRkauD4ottp=O5AwkKM+mf8JJL3c7m-MUu1AmpKLtQ5ucah6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/11/26 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
> On Mon, Nov 25, 2013 at 11:26:00PM +0800, Axel Lin wrote:
>> I got hangup at boot after "VFS: Mounted root (ext2 filesystem) on device 1:0.".
>> I'm using ext2 initrd as root.
> which mainline version are you using? I don't know your problem, and I'm
> not using ext2 on my nommu target. So the only thing I can offer you is
> testing the same version.

Hi Uwe,
My patches for this SoC is on top of current Linus' tree.
I have devtmpfs enabled:
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y

Thanks,
Axel

From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 2 Dec 2012 19:09:36 -0500
Subject: [PATCH] ARM: kirkwood: convert Guruplug to use the device tree
In-Reply-To: <20121202234827.GM30822@1wt.eu>
References: <20121202155124.GA30807@1wt.eu>
 <20121202230926.GJ12509@titan.lakedaemon.net>
 <20121202232226.GL30822@1wt.eu>
 <20121202234110.GM12509@titan.lakedaemon.net>
 <20121202234827.GM30822@1wt.eu>
Message-ID: <20121203000936.GN12509@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 03, 2012 at 12:48:27AM +0100, Willy Tarreau wrote:
> On Sun, Dec 02, 2012 at 06:41:10PM -0500, Jason Cooper wrote:
...
> > btw - did you upgrade u-boot for DT?
> 
> I remember I upgraded it recently because of the incompatibility with
> kernels >= 3.2 causing random hangs at boot, but I don't know if it
> supports DT.
> 
> > You should just have to add
> > CONFIG_OF_LIBFDT to include/configs/guruplug.h.  Then,
> > 
> > bootm <kern addr> <initrd addr> <dtb addr>
> > 
> > Without an initrd,
> > 
> > bootm <kern addr> - <dtb addr>
> 
> Interesting, I'll have to check (I've put it back into my bag right
> now).

v2012.10 does not have it enabled for the guruplug.

hth,

Jason.

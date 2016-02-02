From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 2 Feb 2016 03:20:35 +0100
Subject: [PATCH] ARM: dts: orion5x: add mtd flash support to linkstation
 lswtgl
In-Reply-To: <CAEQ9gEmbw++Qkt0B+5-zN111pn9vFJCfqyBV00=mMTxdKD284A@mail.gmail.com>
References: <1453907405-30434-1-git-send-email-rogershimizu@gmail.com>
 <20160127173231.GI20194@lunn.ch>
 <CAEQ9gEmcss4sb6hE6-w0jVoYfHqnWNf23EVNMefvZ24TYfEk2g@mail.gmail.com>
 <CAEQ9gEkU8x80-S=n+e8NBfN7OTSxHLdBSN_3q6d0JxZDxfs_9g@mail.gmail.com>
 <CAEQ9gEmbw++Qkt0B+5-zN111pn9vFJCfqyBV00=mMTxdKD284A@mail.gmail.com>
Message-ID: <20160202022035.GC12673@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I find "Documentation/devicetree/bindings/mtd/partition.txt" is quite
> new and was just updated in kernel 4.4.
> So I tried "linux-image-4.4.0-trunk-orion5x" in Debian experimental
> repo, YES, with my updated dts, the MTD goes back to work as
> partitioned as before.
> 
> In this way, if I write dts for partition like this, user cannot
> simply take dtb from kernel 4.4/4.5 to their stable kernel (such as
> Debian Jessie's 3.16-ckt series).
> For some advanced functionality, this kind of non-backport capable
> change is deserved; but for partitions IMHO it doesn't deserve,
> especially for a device/platform existing for more than 5 years.
> 
> What do you think?

Since this might be used with older Debian kernel, skipping the
partitions subnode is O.K. for me.

	   Andrew

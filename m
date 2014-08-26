From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Aug 2014 15:43:14 +0200
Subject: [linux-sunxi] Re: [PATCH 4/4] simplefb: add clock handling code
In-Reply-To: <20140826132207.GL15297@lukather>
References: <20140825124410.GZ15297@lukather>
 <20140825133953.GJ4163@ulmo.nvidia.com>
 <53FB3E7F.4000503@redhat.com>
 <20140825141600.GA14763@ulmo.nvidia.com>
 <CAKON4OyjJ+QcBGOzrUDH9J+DxBEKLmXeOcnUyOHHHV_DtCG0zA@mail.gmail.com>
 <53FB47B8.2090104@redhat.com>
 <20140825151255.GA14967@ulmo.nvidia.com>
 <20140825151822.GC21020@skynet.be> <20140826084026.GF17263@ulmo>
 <20140826132207.GL15297@lukather>
Message-ID: <20140826134312.GB2980@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 03:22:07PM +0200, Maxime Ripard wrote:
> On Tue, Aug 26, 2014 at 10:40:27AM +0200, Thierry Reding wrote:
> > On Mon, Aug 25, 2014 at 05:18:22PM +0200, Luc Verhaegen wrote:
> > > On Mon, Aug 25, 2014 at 05:12:58PM +0200, Thierry Reding wrote:
> > > > 
> > > > Out of curiosity, how does this work in practice? How does the
> > > > bootloader create this entry? Does it scan the DT to see which clocks
> > > > the real hardware device references and then simply copies them to the
> > > > simplefb node?
> > > > 
> > > > Thierry
> > > 
> > > https://www.mail-archive.com/linux-sunxi at googlegroups.com/msg06619.html
> > 
> > That looks like a royal pain. Again, I think it'd be much simpler (but
> > not less code, unfortunately) to do this on a per-resource basis. That
> > way these low-level firmware drivers in the kernel can stay trivial,
> > keeping the real complexity where they belong: in hardware-specific
> > drivers such as DRM/KMS.
> 
> So we have to write a DRM/KMS driver in order to have display working
> while waiting for a DRM/KMS driver to be worked on? Come on...

Perhaps you should go and read this thread again. That's not at all what
I've been saying.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140826/55aeadd6/attachment.sig>

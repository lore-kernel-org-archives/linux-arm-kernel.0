From: balbi@ti.com (Felipe Balbi)
Date: Fri, 3 May 2013 09:25:35 +0300
Subject: [PATCH] ARM: OMAP-USB: Fix possible memory leak
In-Reply-To: <20130503062506.GC27451@arwen.pp.htv.fi>
References: <1367510596-27780-1-git-send-email-shc_work@mail.ru>
 <20130502162433.GA10016@kahuna> <1367512124.978518915@f372.mail.ru>
 <20130502164058.GC8577@arwen.pp.htv.fi>
 <20130502231353.GF21614@n2100.arm.linux.org.uk>
 <20130503061931.GB27451@arwen.pp.htv.fi>
 <20130503062506.GC27451@arwen.pp.htv.fi>
Message-ID: <20130503062535.GD27451@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 03, 2013 at 09:25:06AM +0300, Felipe Balbi wrote:
> > > This is exactly why we have platform_device_alloc(),
> > > platform_device_register_full() and friends - so that people don't have to
> > > fsck around with kzalloc themselves and get it wrong like the above does.
> > > 
> > > Would you like me to pass your details to gregkh for another one of his
> > > public humilation exercises over basic kernel programming stuff? :)
> > 
> > How about we pass yours for not reading the patch before flaming ? Note
> > that $SUBJECT is *not* touching at all that line which kzallocs a
> > platform_device. Wrong as it is, it's not part of $SUBJECT.
> 
> that line was added by Roger on commit
> 5ecd52e563f1e14f9cfe06130fbf9fdb73f227e8 (ARM: OMAP2+: omap-usb-host: Add
> usbhs_init_phys()).

forgot to add him to Cc, now done.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130503/45651a32/attachment-0001.sig>

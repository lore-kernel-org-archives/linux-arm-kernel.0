From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 14 Dec 2016 14:38:16 +0100
Subject: [PATCHv6] support for AD5820 camera auto-focus coil
In-Reply-To: <20160808214132.GB2946@xo-6d-61-c0.localdomain>
References: <20160521054336.GA27123@amd>
 <20160808080955.GA3182@valkosipuli.retiisi.org.uk>
 <20160808214132.GB2946@xo-6d-61-c0.localdomain>
Message-ID: <201612141438.16603@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 August 2016 23:41:32 Pavel Machek wrote:
> On Mon 2016-08-08 11:09:56, Sakari Ailus wrote:
> > On Fri, Aug 05, 2016 at 12:26:11PM +0200, Pavel Machek wrote:
> > > This adds support for AD5820 autofocus coil, found for example in
> > > Nokia N900 smartphone.
> > 
> > Thanks, Pavel!
> > 
> > Let's use V4L2_CID_FOCUS_ABSOLUTE, as is in the patch. If we get
> > something better in the future, we'll switch to that then.
> > 
> > I've applied this to ad5820 branch in my tree.
> 
> Thanks. If I understands things correctly, both DTS patch and this
> patch are waiting in your tree, so we should be good to go for 4.9
> (unless some unexpected problems surface)?
> 
> Best regards,
> 									Pavel

Was DTS patch merged into 4.9? At least I do not see updated that dts 
file omap3-n900.dts in linus tree...

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161214/d8addaf7/attachment-0001.sig>

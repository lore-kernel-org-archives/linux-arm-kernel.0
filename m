From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Sun, 19 Oct 2014 16:58:45 +0200
Subject: USB Ethernet gadget on Nokia n900
In-Reply-To: <20141019100739.GA2547@amd>
References: <20141019090107.GA19132@amd> <20141019100739.GA2547@amd>
Message-ID: <201410191658.45851@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 19 October 2014 12:07:39 Pavel Machek wrote:
> On Sun 2014-10-19 11:01:07, Pavel Machek wrote:
> > Hi!
> > 
> > From 3.6 to 3.10, USB networking works on Nokia N900. With
> > 3.11, it fails with messages on the host. I also tried to
> > get it to work on 3.14 and 3.17, with no luck.
> > 
> > Any ideas? Does it work for you? Any config options to watch
> > for?
> 
> With 3.17, I get
> 
> omap_musb_mailbox: musb core is not yet ready
> 
> message. It looks related...?

Can you try tree https://gitorious.org/linux-n900/linux-n900/ ?

I think with rx51_defconfig from above tree it worked fine for 
3.10 - 3.13 versions.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141019/0bffdb99/attachment.sig>

From: corsac@debian.org (Yves-Alexis Perez)
Date: Sun, 11 Mar 2018 12:06:31 +0100
Subject: Bug#887873: linux-image-4.9.0-5-marvell: frequent "usercopy:
 kernel memory overwrite attempt detected" on QNAP NAS (ARM)
In-Reply-To: <1520766137.2953662.1298951624.71C28713@webmail.messagingengine.com>
References: <20180304204115.GD21710@lunn.ch>
 <151652931598.757.4527606947579667082.reportbug@massive.lan>
 <20180305142846.GJ25189@lunn.ch> <1520265474.2408.8.camel@debian.org>
 <1520297697.4117371.1292731088.7BEDFAAE@webmail.messagingengine.com>
 <1520395120.2285859.1294250416.5E5FC747@webmail.messagingengine.com>
 <20180307133611.GC18030@lunn.ch>
 <1520455769.3085111.1295233032.3B89F103@webmail.messagingengine.com>
 <20180307222722.GH1326@lunn.ch>
 <1520589187.923608.1297117744.23E3098C@webmail.messagingengine.com>
 <20180309142724.GD27783@lunn.ch>
 <1520766137.2953662.1298951624.71C28713@webmail.messagingengine.com>
Message-ID: <1520766391.3566.7.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-03-12 at 00:02 +1300, Menno Finlay-Smits wrote:
> Bingo. The problem doesn't seem to happen using linux-image-4.14.0-3-
> marvell_4.14.17-1 from sid. I've now successfully transferred 1.5TB from an
> external USB drive onto the internal hard disk. Previously the problem would
> show up within the first few 100MB of the transfer.
> 
> Do you want me to help figure out which change to the kernel fixed the
> problem?

As far as I can tell and if I'm not mistaken, the fix is already identified
and is included in 4.9.86.

I've started working on it for Stretch, and at one point it will be uploaded
to -proposed-updates for inclusion in the next point release (9.5). When it's
done I'll probably ask you to try a test kernel to make sure it's really
fixed.

Regards,
-- 
Yves-Alexis
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180311/9575cd85/attachment.sig>

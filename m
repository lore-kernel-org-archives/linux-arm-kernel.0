From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 25 Jan 2012 14:53:33 +0000
Subject: Common clock API for i.MX
In-Reply-To: <CAKGA1bm_rLyMB-Xr-XZQHQRVDySu9JuCoVZL=FFv9sa1y6eD1A@mail.gmail.com>
References: <CAKGA1bkHgnJQs3_n6QtQjf-8xaPn0YnxMmE2Q=+opWcsp10zQA@mail.gmail.com>
 <20120125084533.GD1068@n2100.arm.linux.org.uk>
 <CAKGA1bm_rLyMB-Xr-XZQHQRVDySu9JuCoVZL=FFv9sa1y6eD1A@mail.gmail.com>
Message-ID: <20120125145333.GO3687@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2012 at 07:45:15AM -0600, Matt Sealey wrote:
> On Wed, Jan 25, 2012 at 2:45 AM, Russell King - ARM Linux

> > My conclusion, therefore, is that there's very little actual interest
> > amongst the ARM community to move towards a common clk API.

> Maybe it's a chicken-egg thing; nobody wants to work on it until someone else
> has done some legwork? :)

I do think that this is a big part of the issue, the patches have been
floating around for ages and it's not clear when they'll manage to make
it in (and hence when it'll be worth moving to use them).

> > As a result of the lack of motivation by others over this, I've lost
> > interest in it. ?Sorry.

> Can I drum up some interest here? Guys, what's going on? Who was
> ultimately responsible for the code/concept?

Mike Turquette has been driving this for the past while.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120125/01b3dd62/attachment.sig>

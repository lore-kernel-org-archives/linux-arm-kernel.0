From: mina86@mina86.com (Michal Nazarewicz)
Date: Mon, 04 Feb 2013 15:42:26 +0100
Subject: [PATCHv2 1/2] ARM: dma-mapping: add support for CMA regions
 placed in highmem zone
In-Reply-To: <20130204143433.GE17786@n2100.arm.linux.org.uk>
References: <1358350284-6972-2-git-send-email-m.szyprowski@samsung.com>
 <1359984182-6307-1-git-send-email-m.szyprowski@samsung.com>
 <xa1tlib4b30n.fsf@mina86.com> <20130204141053.GD17786@n2100.arm.linux.org.uk>
 <xa1tfw1cb1ho.fsf@mina86.com> <20130204143433.GE17786@n2100.arm.linux.org.uk>
Message-ID: <xa1ta9rkb0od.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, Feb 04, 2013 at 03:24:51PM +0100, Michal Nazarewicz wrote:
>> Perhaps it should use lowmem_page_address() then?

On Mon, Feb 04 2013, Russell King - ARM Linux wrote:
> It's well defined that page_address() will be non-NULL for lowmem pages.
> There is nothing wrong with the above.

It would save on a branch and a function call though.

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 835 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/4533538f/attachment-0001.sig>

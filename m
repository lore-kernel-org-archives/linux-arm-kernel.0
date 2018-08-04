From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 4 Aug 2018 23:23:14 +0200
Subject: [PATCH 00/12] i2c: quirks: add zero length checks and update
 drivers
In-Reply-To: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
References: <20180723202617.15230-1-wsa+renesas@sang-engineering.com>
Message-ID: <20180804212314.oelyhfqxclhatjev@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 10:26:04PM +0200, Wolfram Sang wrote:
> I had this idea for quite some time on my todo list but a soon to be
> implemented refactoring in the i2c-rcar driver now finally made me do it. Add a
> 'can't do 0 length messages' quirk to the quirk infrastructure for and remove
> the manual handling from the drivers. This makes the quirk much more visible.
> (Quite some prominent vendors in that list) We also have a centralized place to
> handle updates to the quirk detection if that is ever needed.
> 
> I have tested this with the i2c-rcar and i2c-sh_mobile driver on a Renesas
> SalvatorXS board equipped with M3-N (r8a77965).
> 
> A git branch can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/quirk-no-zero-len
> 
> Looking forward to comments, reviews, tests...

I applied all the patches which either got acks from the maintainers or
have no maintainers. I'll reply individually to which I applied. I will
wait some more for other acks before I'll resend next cycle.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180804/347af39a/attachment-0001.sig>

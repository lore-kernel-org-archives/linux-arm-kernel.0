From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 23 Oct 2012 14:01:07 +0100
Subject: [PATCH 2/2] Revert "spi/pl022: enable runtime PM"
In-Reply-To: <20121023114842.GA4293@n2100.arm.linux.org.uk>
References: <1349452272-4002-1-git-send-email-ulf.hansson@stericsson.com>
 <1349452272-4002-2-git-send-email-ulf.hansson@stericsson.com>
 <CAPDyKFqfE0u2CPzFKeHBE1LMtuetWabR94KuASPNhw4StDCfjw@mail.gmail.com>
 <20121023111019.GV4477@opensource.wolfsonmicro.com>
 <20121023111656.GT21164@n2100.arm.linux.org.uk>
 <20121023114130.GW4477@opensource.wolfsonmicro.com>
 <20121023114723.GU21164@n2100.arm.linux.org.uk>
 <20121023114842.GA4293@n2100.arm.linux.org.uk>
Message-ID: <20121023130106.GZ4477@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 12:48:42PM +0100, Russell King - ARM Linux wrote:

> Oh, and if you're unwilling to do that, then I'm taking both of Ulf's
> patches, committing them to my fixes branch, and sending them off to
> Linus tonight - because they are _NEEDED_ for the -rc series to fix
> this driver.

As I said in my previous e-mail I've now done the revert myself; I'll
send the fixes to Linus.  If you wish to check the other patches that
are queued they're in -next like I said; I'd appreciate someone who's
actively using the driver taking a look at them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/8bb0e238/attachment.sig>

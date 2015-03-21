From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Mar 2015 18:22:59 +0000
Subject: [PATCH 05/10] ARM: s3c64xx: enable sparse IRQ support
In-Reply-To: <20150321163821.GE23705@opensource.wolfsonmicro.com>
References: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
 <1425299763-4066822-6-git-send-email-arnd@arndb.de>
 <20150306174316.GA26692@opensource.wolfsonmicro.com>
 <6643361.dhtMagqMYZ@wuerfel> <20150318000234.GU28806@sirena.org.uk>
 <20150321163821.GE23705@opensource.wolfsonmicro.com>
Message-ID: <20150321182259.GV2869@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 21, 2015 at 04:38:21PM +0000, Charles Keepax wrote:

> So adding a bit of an offset into the PMIC with the fixed IRQ
> base fixes the problem. Although I am not sure if it would be
> better to move both PMICs onto a fixed IRQ base so there is no
> chance of the clashing. Any thoughts?

Yes, that sounds like the safest thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150321/7762cffd/attachment.sig>

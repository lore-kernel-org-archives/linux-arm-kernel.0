From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Jul 2015 10:18:36 +0200
Subject: [PATCH v11] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20150720081050.GB12908@gondor.apana.org.au>
References: <1437143983-4479-1-git-send-email-clabbe.montjoie@gmail.com>
 <20150720081050.GB12908@gondor.apana.org.au>
Message-ID: <20150720081836.GT28632@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 04:10:50PM +0800, Herbert Xu wrote:
> On Fri, Jul 17, 2015 at 04:39:37PM +0200, LABBE Corentin wrote:
> > Hello
> > 
> > This is the driver for the Security System included in Allwinner SoC A20.
> > The Security System (SS for short) is a hardware cryptographic accelerator that
> > support AES/MD5/SHA1/DES/3DES/PRNG algorithms.
> > It could be found on others Allwinner SoC: 
> > - A10, A10s, A13, A31 and A33 manual give the same datasheet for SS than A20
> > - A23 speak about a security system but without precisions
> > - A80 and A83T datasheet speak about a security system with more functions
> >   (SHA224/SHA256/RSA/CRC), they will be supported in a separate driver.
> 
> All applied.  Thanks a lot!

All applied, DT bits included?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/8d1f352f/attachment.sig>

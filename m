From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Jul 2014 15:48:57 +0200
Subject: [PATCH v4 3/3] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20140723131620.GC29178@gondor.apana.org.au>
References: <1405169953-13695-1-git-send-email-clabbe.montjoie@gmail.com>
 <1405169953-13695-4-git-send-email-clabbe.montjoie@gmail.com>
 <20140723131620.GC29178@gondor.apana.org.au>
Message-ID: <20140723134857.GO20328@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 23, 2014 at 09:16:20PM +0800, Herbert Xu wrote:
> On Sat, Jul 12, 2014 at 02:59:13PM +0200, LABBE Corentin wrote:
> > Add support for the Security System included in Allwinner SoC A20.
> > The Security System is a hardware cryptographic accelerator that support AES/MD5/SHA1/DES/3DES/PRNG algorithms.
> > 
> > Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> 
> This is essentially a synchronous driver, no? If so please
> switch to the blkcipher/shash interface.

The exact opposite has been asked for during v1's review...

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140723/201fc9ae/attachment.sig>

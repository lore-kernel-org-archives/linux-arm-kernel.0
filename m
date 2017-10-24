From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 24 Oct 2017 11:20:36 +0800
Subject: Kernel panic when using ccm(aes) with the Atmel AES HW accelerator
In-Reply-To: <39a43561-e0e6-a3b7-e2c0-bd7e6bf1be47@microchip.com>
References: <CAGkQfmP6Kq4DEBbGU7AW71PjbUJ2acdJF5PVDm6VqZkUaaoEzA@mail.gmail.com>
 <39a43561-e0e6-a3b7-e2c0-bd7e6bf1be47@microchip.com>
Message-ID: <20171024032036.GA28462@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 03:38:59PM +0300, Tudor Ambarus wrote:
>
> I will propose a fix, but I'm taking my time to better understand why
> CTR requires to overwrite the iv with the last ciphertext block.

That's an API requirement.  So we should fix ccm.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

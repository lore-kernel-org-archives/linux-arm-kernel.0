From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 30 Nov 2015 16:50:54 +0800
Subject: [PATCH v2 0/3] dmaengine: Add supports for APM X-Gene SoC CRC32C
 accerlerator driver
In-Reply-To: <CAFd313z2dncWmBQJY48RkReVOhQqLs13UzehwrbizBbputOSEw@mail.gmail.com>
References: <rsahu@apm.com> <1447665169-14003-1-git-send-email-rsahu@apm.com>
 <CAFd313zqimQtG8epeo3U7gzxWRf0hqO4K8hOFy4UK-6pG5GcJg@mail.gmail.com>
 <20151130083950.GA7792@gondor.apana.org.au>
 <CAFd313z2dncWmBQJY48RkReVOhQqLs13UzehwrbizBbputOSEw@mail.gmail.com>
Message-ID: <20151130085054.GA7928@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 02:19:33PM +0530, Rameshwar Sahu wrote:
>
> One of our client is using this layer for offloading the crc32c to our
> dmaengine hw.

Is this going to be merged into the kernel?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

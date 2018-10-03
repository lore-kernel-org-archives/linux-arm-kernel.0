From: ebiggers@kernel.org (Eric Biggers)
Date: Tue, 2 Oct 2018 23:12:37 -0700
Subject: [PATCH net-next v6 11/23] zinc: import Andy Polyakov's Poly1305
 ARM and ARM64 implementations
In-Reply-To: <20180925145622.29959-12-Jason@zx2c4.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
 <20180925145622.29959-12-Jason@zx2c4.com>
Message-ID: <20181003061236.GB745@sol.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2018 at 04:56:10PM +0200, Jason A. Donenfeld wrote:
> These NEON and non-NEON implementations come from Andy Polyakov's
> implementation, and are included here in raw form without modification,
> so that subsequent commits that fix these up for the kernel can see how
> it has changed. This awkward commit splitting has been requested for the
> ARM[64] implementations in particular.
> 
> While this is CRYPTOGAMS code, the originating code for this happens to
> be the same as OpenSSL's commit 5bb1cd2292b388263a0cc05392bb99141212aa53

Sorry to ruin the fun, but actually there are no Poly1305 implementations in
CRYPTOGAMS (https://github.com/dot-asm/cryptogams).  Nor are there any ChaCha20
implementations.

Andy P., can you please add your Poly1305 and ChaCha20 implementations to the
CRYPTOGAMS repository, so that they have a clear kernel-compatible license?

It would be great if you'd include a kernel-compatible license directly in the
versions in the OpenSSL tree too...

Thanks!

- Eric

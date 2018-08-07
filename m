From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 7 Aug 2018 08:57:17 +0200
Subject: [PATCH v2] crypto: remove Speck
In-Reply-To: <20180807062225.6331-1-Jason@zx2c4.com>
References: <20180807011937.GA133621@gmail.com>
 <20180807062225.6331-1-Jason@zx2c4.com>
Message-ID: <CAKv+Gu893jhyC9m++r719845-7axqj5qCPhk7hp-iStykj+HsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 August 2018 at 08:22, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> These are unused, undesired, and have never actually been used by
> anybody. The original authors of this code have changed their mind about
> its inclusion. While originally proposed for disk encryption on low-end
> devices, the idea was discarded [1] in favor of something else before
> that could really get going. Therefore, this patch removes Speck.
>
> [1] https://marc.info/?l=linux-crypto-vger&m=153359499015659
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Acked-by: Eric Biggers <ebiggers@google.com>
> Cc: stable at vger.kernel.org

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

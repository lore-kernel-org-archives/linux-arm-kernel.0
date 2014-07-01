From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 1 Jul 2014 20:01:53 +0100
Subject: [PATCH v2 0/5] efistub: convert into static library
In-Reply-To: <CAKv+Gu8eN4s9V6=mmQFpMDKuuMRE0y5T6pxk27=BLMFRX1O57w@mail.gmail.com>
References: <1403792617-25792-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140701183906.GH7539@console-pimps.org>
 <CAKv+Gu8eN4s9V6=mmQFpMDKuuMRE0y5T6pxk27=BLMFRX1O57w@mail.gmail.com>
Message-ID: <20140701190153.GI7539@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 01 Jul, at 08:55:20PM, Ard Biesheuvel wrote:
> 
> OK, thanks. One tiny snag that I would like to fix up once we have
> some Acks to add: I just noticed that i removed the 'static' from
> handle_kernel_image()'s definition from arm64 in 4/5, but removed it
> from the forward declaration in 5/5, which likely breaks bisect for
> arm64 if you happen to end up right in the middle.

Good catch.

I rebase 'next' pretty feely, so just remind me at some point in the
future and we can fix this up.

-- 
Matt Fleming, Intel Open Source Technology Center

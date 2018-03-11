From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Sun, 11 Mar 2018 14:23:12 -0700
Subject: [PATCH v8 1/6] arch: enable relative relocations for arm64, power
 and x86
In-Reply-To: <CAKv+Gu_E8mVqaR9OmzP2whc7WHGaFX5ypCh7F0UHEyY1DY_t3Q@mail.gmail.com>
References: <20180311123815.17916-1-ard.biesheuvel@linaro.org>
 <20180311123815.17916-2-ard.biesheuvel@linaro.org>
 <CA+55aFxcB+5oB_hL83EASOJQrVRCrzT9iS+2+XtEUToG6VHiqA@mail.gmail.com>
 <CAKv+Gu_E8mVqaR9OmzP2whc7WHGaFX5ypCh7F0UHEyY1DY_t3Q@mail.gmail.com>
Message-ID: <CA+55aFwTUY5s6nh+bmmDyVEoz6ntt5OgdduKUbTnMn5e0q8Y3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 11, 2018 at 1:35 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> I'm sure all of these architectures define some kind of 32-bit place
> relative relocation in their ELF psABI, and I see how it would be
> cleaner to change everything at once, but I anticipate a long tail of
> issues with toolchains for niche architectures that I have no way to
> test.

Ok, fair enough.

           Linus

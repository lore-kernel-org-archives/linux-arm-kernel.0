From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Feb 2018 10:37:46 +0100
Subject: [PATCH 4/5 v2] drm/pl111: Support variants with broken VBLANK
In-Reply-To: <87efm1bput.fsf@anholt.net>
References: <20180201125513.5482-1-linus.walleij@linaro.org>
 <20180201125513.5482-5-linus.walleij@linaro.org> <87efm1bput.fsf@anholt.net>
Message-ID: <CACRpkdYMHjkWwXs4NZRv6Y3FhTt2A27c6dM-xi+4h8EbFRBAgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 4, 2018 at 12:44 AM, Eric Anholt <eric@anholt.net> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:
>
>> The early Integrator CLCD synthesized in the Integrator CP and
>> IM-PD1 FPGAs are broken: their vertical and next base interrupts
>> are not functional. Support these variants by simply disabling
>> the use of the vblank interrupt on these variants.
>
> I do wonder if we just have the vblank interrupt number wrong or
> something for Integrator.  However, let's get to at least functional
> parity with fbdev before we worry too much about the new features that
> DRM can bring us.
>
> The remainder of this series is also:
>
> Reviewed-by: Eric Anholt <eric@anholt.net>

Thanks man, sent it out again with your review tag (I do this
to pick it to the dim-script thing with tags and all). And as a last
checkpoint for everyone else.

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Jan 2018 16:39:51 +0100
Subject: [PATCH 2/4] drm/pl111: Properly detect the PL110+ variant
In-Reply-To: <871si8xm8w.fsf@anholt.net>
References: <20180126132033.19744-1-linus.walleij@linaro.org>
 <20180126132033.19744-2-linus.walleij@linaro.org> <871si8xm8w.fsf@anholt.net>
Message-ID: <CACRpkdaqAH0czo6Wn5eCQvDd=t1UfueV-T4eF3VGjsVQmVPSPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 30, 2018 at 12:45 AM, Eric Anholt <eric@anholt.net> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:
>
>> With a bit of refactoring we can contain the variant data for
>> the "PL110+" version that is somewhere inbetween PL110 and PL111.
>> This is used on the ARM Versatile AB and Versatile PB.
>
> Patch 2-3 are:
>
> Reviewed-by: Eric Anholt <eric@anholt.net>

Thanks! I'll have to respin this patch 2 because it was a bit
to bad at separation of concerns.

Sorry for the fuzz.
Linus Walleii

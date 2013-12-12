From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 22:23:38 +0100
Subject: [PATCH CFT] ARM:S5P64X0: Enable ARM_PATCH_PHYS_VIRT and
 AUTO_ZRELADDR by default
In-Reply-To: <CA+Ln22EaSpzrSaW-TC1BMhnj8aPZMfK9pCTqBMnGXC3B-06FBQ@mail.gmail.com>
References: <1386825152-398-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
 <26167386.hX5eWUjT6T@flatron>
 <CACRpkdbGSXA8oT8L-0fzJx7esXn7GWQA+Wi7WCQKX9eiy-fYCQ@mail.gmail.com>
 <CA+Ln22EaSpzrSaW-TC1BMhnj8aPZMfK9pCTqBMnGXC3B-06FBQ@mail.gmail.com>
Message-ID: <CACRpkdYpQzue=_di1YhfvmQ47kdg0ydsZhKrWDyk9sJU9u_xHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 10:22 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> 2013/12/12 Linus Walleij <linus.walleij@linaro.org>:
>> On Thu, Dec 12, 2013 at 10:47 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>
>>> This is actually quite a poor platform choice. As of today, the kernel
>>> is stuck with supporting just SMDK6440/6450 boards, which are proprietary
>>> development boards and it doesn't look like any further boards will show
>>> up in future. Kukjin has actually proposed removing support for this
>>> platform at all and I consider this reasonable.
>>>
>>> Kukjin, should we proceed with removal?
>>
>> Isn't Mark Brown using that platform for some various stuff?
>
> Not as far as I know.
>
> He's using Cragganmore board based on s3c6410, but this is a different
> platform (s3c64xx).

Ahhhh I see it now. So the S3C:s are actually in a lot of use
and the S5P is one of those stepping stones to Exynos that
never really was in any widespread use.

Yeah I'm all for deleteing that :-)

Thanks!
Linus Walleij

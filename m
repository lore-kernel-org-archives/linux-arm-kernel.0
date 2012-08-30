From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Aug 2012 16:56:03 -0700
Subject: [PATCH 13/22] ARM: ux500: Fork MSP platform registration for
 step-by-step DT enablement
In-Reply-To: <20120828074812.GA12957@gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-14-git-send-email-lee.jones@linaro.org>
 <CACRpkdaem6t3mvy-_9e=GEgwWoeBQSoX3Hf1L=hjWsvLJdsVAQ@mail.gmail.com>
 <20120820080632.GD8450@gmail.com>
 <CACRpkdZRJ1yX-o8-NUuMzXMz5ebbp=H21Xa6JMy1y56Chq-T9g@mail.gmail.com>
 <20120828074812.GA12957@gmail.com>
Message-ID: <CACRpkdY0jwV7MOOGbFOcFhujMzanRyxx6TofA72ZwLi_D4HhHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 12:48 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, Aug 27, 2012 at 04:07:58PM -0700, Linus Walleij wrote:

>> If you're adding and then removing *all* of them in this set,
>> why add them in the first place?
>
> So that there's no breakage during bisection.
>
> You should be able to roll the kernel back in between each of these
> patches and there to be full compatibility at each point. At least
> that was the intention. Is that wrong?

No it's correct, the only way to do what I'm thinking on may be
to squash them all into one gigantic patch, which is not good either.

So go ahead with this scheme, it's the lesser of two evils.
Acked-by etc.

Yours,
Linus Walleij

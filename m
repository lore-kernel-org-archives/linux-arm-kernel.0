From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 Mar 2016 10:57:37 +0100
Subject: [linux-sunxi] [PATCH 1/4] gpio: Add AXP209 GPIO driver
In-Reply-To: <87io0v23fz.fsf@dell.be.48ers.dk>
References: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
 <1457520614-32239-2-git-send-email-maxime.ripard@free-electrons.com>
 <87io0v23fz.fsf@dell.be.48ers.dk>
Message-ID: <CACRpkdY4L4uVAF9er4eD5jn8wsMfdtOoHn3r8qUzYxY3eySSLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 9, 2016 at 2:20 PM, Peter Korsgaard <peter@korsgaard.com> wrote:
>>>>>> "Maxime" == Maxime Ripard <maxime.ripard@free-electrons.com> writes:

>  > +    dev_info(&pdev->dev, "AXP209 GPIO driver loaded\n");
>
> Any reason to be so noisy?

The GPIO maintainer likes boasty drivers.

I don't understand people who are dmesg minimalists, I want to
have positive indications that things work in there, not just bad news
about what went wrong.

Yours,
Linus Walleij

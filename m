From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Mar 2015 09:32:39 +0100
Subject: [PATCH] pinmux: allow exlusive pin allocation among GPIO and
 peripheral funtions via flag strict in struct pinctrl_desc
In-Reply-To: <CAJxxZ0OC0xDs3Y_kn=_r59Sx8mf3aUxE9unH+8mjuEsQrK8q=A@mail.gmail.com>
References: <1426154203-11551-1-git-send-email-sonic.adi@gmail.com>
 <CACRpkdZ-wmZRHR1eTwhaNYcot=T4GVX2spm80hv8Makw99bowQ@mail.gmail.com>
 <CAJxxZ0OC0xDs3Y_kn=_r59Sx8mf3aUxE9unH+8mjuEsQrK8q=A@mail.gmail.com>
Message-ID: <CACRpkdYFDPG9SxtMbX21_VUZBCShCVw6TJTdswmVNXhZ051dsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 11:06 AM, Sonic Zhang <sonic.adi@gmail.com> wrote:

> Anyway, if you think doing the explicit check in both if() and else()
> clauses is better, I am fine to send a new patch.

I looked at it for half an hour and could not figure out if it was
wrong or right really, eventually maybe got it wrong, maybe right.

What is happening is that the code is getting so convoluted that I cannot
follow the program flow, which is a clear sign that refactoring is needed.

Either restructure, add comments or break our helper functions.

Yours,
Linus Walleij

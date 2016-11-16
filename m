From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 Nov 2016 21:12:05 +0100
Subject: [PATCH 1/3 v4] ARM: dts: rename MSM8660/APQ8060 pmicintc to pm8058
In-Reply-To: <1478508284-10847-1-git-send-email-linus.walleij@linaro.org>
References: <1478508284-10847-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdbLGJNbE2cp+t9vk=qXoOn7E98=0daEeU-R908B_A_HCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 7, 2016 at 9:44 AM, Linus Walleij <linus.walleij@linaro.org> wrote:

> The name "pmicintc" is ambiguous: there is a second power
> management IC named PM8901 on these systems, and it is also
> an interrupt controller. To make things clear, just name the
> node alias "pm8058", this in unambigous and has all information
> we need.
>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v4:
> - Add Bjorn's ACK.
> - Follow version numbering of the primary patch.

Are these three patches getting applied?

I don't see them in -next or anything...

Yours,
Linus Walleij

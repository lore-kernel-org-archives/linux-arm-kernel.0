From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Jul 2012 09:11:32 +0200
Subject: [PATCH 6/9] ARM: ux500: Remove PMU platform registration when
 booting with DT
In-Reply-To: <1341493572-29735-7-git-send-email-lee.jones@linaro.org>
References: <1341493572-29735-1-git-send-email-lee.jones@linaro.org>
 <1341493572-29735-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdanWJyK1OoXUCRiypoprJwefJ9zEkEVTS5f7V-sRR_z=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 5, 2012 at 3:06 PM, Lee Jones <lee.jones@linaro.org> wrote:

> PMU registration is successfully completed by Device Tree now, so
> there is no longer a requirement to register it from platform code.
> This patch removes platform registration during a DT boot.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

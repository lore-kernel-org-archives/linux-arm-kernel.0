From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 22:33:36 +0200
Subject: [PATCH 2/9] ARM: ux500: Remove incorrect DB9540 PRCMU TCDM base
 location
In-Reply-To: <1364908916-29803-2-git-send-email-lee.jones@linaro.org>
References: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
 <1364908916-29803-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdapOBRLAtYOh=CvfqDbxxovn+qO0QiOhGCrYtv2qSt-Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 2, 2013 at 3:21 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The Tightly Coupled Data Memory for the DB9540 is actually in the
> same place as the DB8500's. This definition is just plain wrong.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied.

Yours,
Linus Walleij

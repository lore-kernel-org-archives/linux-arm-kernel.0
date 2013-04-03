From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 22:38:41 +0200
Subject: [PATCH 4/9] ARM: ux500: Move Snowball's thermal DT node into
 existing PRCMU one
In-Reply-To: <1364908916-29803-4-git-send-email-lee.jones@linaro.org>
References: <1364908916-29803-1-git-send-email-lee.jones@linaro.org>
 <1364908916-29803-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdar=xD34yaMP2gOfUPkpxOhDymS6zTedKOEW7j2DNHusA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 2, 2013 at 3:21 PM, Lee Jones <lee.jones@linaro.org> wrote:

> When the thermal DT node was inserted a new PRCMU node was created;
> however, one already exists in the Snowball DTS file. Here we
> amalgamate the two into a single consolidated node.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied.

Thanks,
Linus Walleij

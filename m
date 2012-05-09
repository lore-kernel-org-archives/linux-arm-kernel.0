From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 May 2012 11:05:42 +0200
Subject: [PATCH 15/15] ARM: ux500: Disable platform setup of the ab8500
 when DT is enabled
In-Reply-To: <1336155805-18554-16-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-16-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYDTM4wsnv4ZrEznR-XzQx07oRvL60Mm_1CRPk8GvmuZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2012 at 8:23 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The final piece of the ab8500 puzzle. Here we prevent any of the ab8500-*
> drivers from being registered from platform code when Device Tree is
> enabled, as we expect DT do probe each of these individually. We also
> provide the relevant compatible strings, so that DT knows which nodes
> it needs to pay attention to during population.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

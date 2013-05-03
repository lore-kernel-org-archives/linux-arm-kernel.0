From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 21:27:47 +0200
Subject: [PATCH 01/63] ARM: ux500: Supply address location names for the
 DMA40 DMA controller
In-Reply-To: <1367591569-32197-2-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdacfGZ5tWiKM_RxbaQv+8QQaU1Wq_7TgYHtHTNqr9BqVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 4:31 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The DMA40 controller uses two sets of base addresses. In order to have
> the resources setup by the of_platform framework so they are searchable
> by name instead of index, we have to set names for them. The names have
> to be the same as the ones used to fetch them back out of the resource
> structure.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied this one to my ux500-devicetree branch.

Thanks,
Linus Walleij

From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 10 Oct 2012 10:51:37 +0200
Subject: [PATCH 10/16] pinctrl: samsung: Do not pass gpio_chip to
 pin_to_reg_bank
In-Reply-To: <CACRpkdYinRRictTsH-zp=Y7FPAd92NP6E1WMU6YoupJDeYre8A@mail.gmail.com>
References: <1349685556-23718-1-git-send-email-t.figa@samsung.com>
 <1349685556-23718-11-git-send-email-t.figa@samsung.com>
 <CACRpkdYinRRictTsH-zp=Y7FPAd92NP6E1WMU6YoupJDeYre8A@mail.gmail.com>
Message-ID: <1519398.vRBS8CYjxJ@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 of October 2012 09:42:10 Linus Walleij wrote:
> On Mon, Oct 8, 2012 at 10:39 AM, Tomasz Figa <t.figa@samsung.com> wrote:
> > The pointer to gpio_chip passed to pin_to_reg_bank utility function is
> > used only to retrieve a pointer to samsung_pinctrl_drv_data structure.
> > 
> > This patch modifies the function and its users to pass a pointer to
> > samsung_pinctrl_drv_data directly.
> > 
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> 
> Looks good, can it be applied without the others?

Yes, I think this one should apply fine.

> Maybe you can make a patch series without all the
> stuff moving register offsets to the DT so I can begin
> with merging that and we can discuss the movement
> of register info separately?

I already considered this approach, but it introduces some problems, as I 
mentioned in my other replies.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center

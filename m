From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 09 Feb 2013 09:22:32 +0000
Subject: [PATCH 2/9] gpiolib: use gpio_chips list in gpiolib_sysfs_init
In-Reply-To: <CACRpkdaz8h_1uKoH1q9gLmCxE0BMAxBakaq_eFfnfJr2V_Ct5w@mail.gmail.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-4-git-send-email-acourbot@nvidia.com>
 <CACRpkdaz8h_1uKoH1q9gLmCxE0BMAxBakaq_eFfnfJr2V_Ct5w@mail.gmail.com>
Message-ID: <20130209092232.64D0A3E2C01@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Feb 2013 18:04:43 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:
> 
> > Use the small list of GPIO chips instead of parsing the whole GPIO
> > number space.
> >
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 

Applied, thanks.

g.

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

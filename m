From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jul 2013 11:00:20 +0200
Subject: [PATCH 07/10] pinctrl: sunxi: Add Allwinner A31 pins set
In-Reply-To: <CACRpkdZ1RhsLMC0xWDDr9Hmy78i+uU-9x0-2Y+_NvRZ-yefmVw@mail.gmail.com>
References: <1374618312-19001-1-git-send-email-maxime.ripard@free-electrons.com>
 <1374618312-19001-8-git-send-email-maxime.ripard@free-electrons.com>
 <CACRpkdZ1RhsLMC0xWDDr9Hmy78i+uU-9x0-2Y+_NvRZ-yefmVw@mail.gmail.com>
Message-ID: <20130730090020.GF1441@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, Jul 29, 2013 at 06:20:13PM +0200, Linus Walleij wrote:
> On Wed, Jul 24, 2013 at 12:25 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> 
> > The Allwinner A31 SoC uses the same IP than the one found in the
> > A10/A13, with only different pins. Add the pins and the associated
> > functions found in the A31.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Will you carry this through ARM SoC or do you want me to merge
> this into the pinctrl tree? It seems pretty independent.

I'd prefer if you could merge it through the pinctrl tree.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130730/045c63a8/attachment.sig>

From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Aug 2011 00:48:49 +0200
Subject: [PATCH] mach-davinci: fix cache flush build error
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DF05E85@dbde02.ent.ti.com>
References: <1312300118-9088-1-git-send-email-linus.walleij@stericsson.com>
	<20110802160234.GH19079@n2100.arm.linux.org.uk>
	<B85A65D85D7EB246BE421B3FB0FBB593024DF05E85@dbde02.ent.ti.com>
Message-ID: <CACRpkdZ12S8qC_5VbV2d3BpCtZQpR5U9OHyxMR61bo92L83WLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 3, 2011 at 7:19 PM, Nori, Sekhar <nsekhar@ti.com> wrote:

> This isn't the only thing that prevents building the TNET variant
> with the rest of the DaVinci variants.
>
> If you enable DM365 and TNETV107x together, you get errors:

Looks like it needs some KConfig patch to disallow such combinations
then?

> Considering this, Linus's patch looks fair to me. If there are no
> objections, I will queue for v3.1-rc

Thanks!

> Linus, in future can you please CC me and/or Kevin on DaVinci patches?

Yeah, sorry. Will do better.
Linus Walleij

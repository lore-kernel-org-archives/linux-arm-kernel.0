From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 16 Feb 2012 19:57:16 +0100
Subject: [PATCH 14/15] ARM: remove bunch of now unused mach/io.h files
In-Reply-To: <1329169408-17253-15-git-send-email-robherring2@gmail.com>
References: <1329169408-17253-1-git-send-email-robherring2@gmail.com>
 <1329169408-17253-15-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdYKe_HqXAnD+66FMEn+Gzn+CWS_aWZgfyTipONPbfkH2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 10:43 PM, Rob Herring <robherring2@gmail.com> wrote:

> Now that many platforms don't need mach/io.h, remove the usused ones.
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Great!

For these:
> ?arch/arm/mach-nomadik/include/mach/io.h ? | ? 22 -------------
> ?arch/arm/mach-u300/include/mach/io.h ? ? ?| ? 20 ------------
> ?arch/arm/mach-ux500/include/mach/io.h ? ? | ? 22 -------------

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

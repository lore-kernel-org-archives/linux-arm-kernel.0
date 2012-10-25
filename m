From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Oct 2012 08:58:10 +0200
Subject: [PATCH 3/3] pinctrl: mvebu: move to its own directory
In-Reply-To: <1351114738-26793-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1351114738-26793-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351114738-26793-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdY3iPHDKQS5Z4_5KvrceGBUby6jambtQXaJLH6DVfUjHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 11:38 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> Like the spear platform, the mvebu platform has multiple files: one
> core file, and then one file per SoC family. More files will be added
> later, as support for mach-orion5x and mach-mv78xx0 SoCs is added to
> pinctrl-mvebu. For those reasons, having a separate subdirectory,
> drivers/pinctrl/mvebu/ makes sense, and it had already been suggested
> by Linus Wallej when the driver was originally submitted.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks, patch applied.

Yours,
Linus Walleij

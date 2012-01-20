From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Jan 2012 13:33:33 +0100
Subject: [st-ericsson] [PATCH] mach-ux500: sdi: MMC_CAP_SD_HIGHSPEED
 capability is not yet supported on Snowball
In-Reply-To: <1327047640-15383-1-git-send-email-philippe.langlais@stericsson.com>
References: <1327047640-15383-1-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <CACRpkdZC3mJM3aZzN2cKESDYVOU95PT6gx=U9Fci20REiNH-Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 9:20 AM, Philippe Langlais
<philippe.langlais@stericsson.com> wrote:

> From: Philippe Langlais <philippe.langlais@linaro.org>
>
> MMC_CAP_SD_HIGHSPEED is not supported on Snowball board resulting on
> initialisation errors.
>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>
> Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>

OK applied to ux500-fixes for the -rc:s.

I have added stable at kernel.org to the CC, since this affects any
kernel supporting Snowball.

Yours,
Linus Walleij

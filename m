From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 19 Dec 2010 21:53:23 +0100
Subject: [PATCH 03/20] mach-ux500: move keymaps to new file
In-Reply-To: <1291388753-14662-4-git-send-email-sundar.iyer@stericsson.com>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
	<1291388753-14662-4-git-send-email-sundar.iyer@stericsson.com>
Message-ID: <AANLkTikMtL=+HJfivh2MVfyzNvT8NyRXVcgPJNEV9XQu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/3 Sundar Iyer <sundar.iyer@stericsson.com>:

> Move keylayouts to a dedicated file and plug these keylayouts
> for input platform data. This will make addition of new and custom
> keylayouts localized.

Managed to rebase this somewhat easily on top of the last
batch of tc3589x MFD patches and pushed for ux500-core,
please check that I didn't screw anything up.

Yours,
Linus Walleij

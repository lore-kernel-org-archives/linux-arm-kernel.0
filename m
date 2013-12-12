From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 15:44:03 +0100
Subject: [PATCH 2/3] pinctrl: at91: initialize config parameter to 0
In-Reply-To: <1386421734-10240-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1386421734-10240-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1386421734-10240-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <CACRpkdaA+vcwiok8_jv8tNRwgPFWeXFcd_zRs4M3rH2W4FG1Zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 7, 2013 at 2:08 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> When passing a not initialized config parameter, at91_pinconf_get() would return
> a bogus value. Fix that by initializing it to zero before using it.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Patch applied.

Yours,
Linus Walleij

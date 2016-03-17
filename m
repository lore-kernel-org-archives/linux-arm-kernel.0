From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 17 Mar 2016 15:49:58 +0100
Subject: [PATCH 10/17] pinctrl: Add PLX Technology OXNAS pinctrl and gpio
 driver
In-Reply-To: <56E9750B.2000800@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-11-git-send-email-narmstrong@baylibre.com>
 <CACRpkdby7XmbK2ZpwX3zy5J=yr1HRbmfWVab3K0ArcL6wd=oyA@mail.gmail.com>
 <56E9750B.2000800@baylibre.com>
Message-ID: <CACRpkdbWZDpM5ctNkU5cRasaATjkoa_zrg_-xgnTpbYRZK2pXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2016 at 4:00 PM, Neil Armstrong <narmstrong@baylibre.com> wrote:

> I think I'll reboot over a clean base, could you give a reference driver I should follow ?
> It's a very simple HW, it should be easy.

I would look at those merged lately, which has pin control
combined with GPIO and interrupts.

drivers/pinctrl/qcom is good but supports quite a lot of
subvariants so it may be hard to see what parts you really
need. But I think of those as a very nice drivers.

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 11:07:14 +0200
Subject: [PATCH] pinctrl: vt8500: Fix incorrect data in WM8750 pinctrl
 table
In-Reply-To: <1368207956-32220-1-git-send-email-linux@prisktech.co.nz>
References: <1368207956-32220-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <CACRpkdZC4RC-OnGJYNooRRoc7q5d1x8PH26+cnwBHw8ppzynEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 10, 2013 at 7:45 PM, Tony Prisk <linux@prisktech.co.nz> wrote:

> WMT_PIN_WAKEUP1 should be declared as WMT_PIN(0, 17) rather than
> WMT_PIN(0, 16). This currently generates a runtime warning because
> WMT_PIN_WAKEUP0 is already defined as WMT_PIN(0, 16).
>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

Applied to my fixes branch.

Yours,
Linus Walleij

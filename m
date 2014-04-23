From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Apr 2014 23:19:11 +0200
Subject: [PATCH 1/2] pinctrl: rockchip: return a complete config in
 pinconf_get
In-Reply-To: <7604038.VoEVFUfvet@phil>
References: <7604038.VoEVFUfvet@phil>
Message-ID: <CACRpkdZ8Wsvh+hi8NXNk=82XbbB3n3AsAQ7Nr1KOnWB9tUv8qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 2:27 PM, Heiko St?bner <heiko@sntech.de> wrote:

> Till now pinconf_get only set the argument value into the config parameter
> effectively removing the actual config param value. As other pinctrl drivers
> do, it might be nicer to keep the config param intact.
> Therefore construct a real pinconfig value from param and arg in pinconf_get
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Patch applied.

Yours,
Linus Walleij

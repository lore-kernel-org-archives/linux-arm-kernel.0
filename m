From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Oct 2016 15:13:29 +0200
Subject: [PATCH 0/3] pinctrl: sunxi: Support generic pinconf functions
In-Reply-To: <20161004015112.20833-1-wens@csie.org>
References: <20161004015112.20833-1-wens@csie.org>
Message-ID: <CACRpkdZHTQqnsuHcm3+iYQJc2picLu95W2OKeMiXFq+XNzDV3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 4, 2016 at 3:51 AM, Chen-Yu Tsai <wens@csie.org> wrote:

> This series fixes up generic pinconf support for the sunxi pinctrl driver
> library. The driver was doing some bits wrong, like a) storing the pinconf
> config value in its struct, and not actually reading the hardware to get
> the current config, and b) not using the right arguments for the bias
> parameters.

Looks OK to me, Maxime are you OK with me applying this, or
are we waiting for a new iteration of this patch set?

I have started to apply Maxime's generic binding rework, will it
clash with these?

Yours,
Linus Walleij

From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Jan 2018 10:26:09 +0100
Subject: [PATCH v2 3/5] pinctrl: imx: constify struct imx_pinctrl_soc_info
In-Reply-To: <20180106142553.15322-4-stefan@agner.ch>
References: <20180106142553.15322-1-stefan@agner.ch>
 <20180106142553.15322-4-stefan@agner.ch>
Message-ID: <CACRpkdaP==bSxdSD7D50M8ZkH9p3BbLtCKL7mqyerk=qPHQ73w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 6, 2018 at 3:25 PM, Stefan Agner <stefan@agner.ch> wrote:

> Now that imx_pinctrl_probe accepts const struct imx_pinctrl_soc_info
> we can constify all declarations of struct imx_pinctrl_soc_info.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Patch applied.

Yours,
Linus Walleij

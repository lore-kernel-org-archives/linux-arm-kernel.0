From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Jan 2018 10:25:31 +0100
Subject: [PATCH v2 2/5] pinctrl: imx7d: simplify imx7d_pinctrl_probe
In-Reply-To: <20180106142553.15322-3-stefan@agner.ch>
References: <20180106142553.15322-1-stefan@agner.ch>
 <20180106142553.15322-3-stefan@agner.ch>
Message-ID: <CACRpkdZK-0XFNKoCzn=aYHsXoVMzUZJBTGsdNAQ=z4QxrGbdtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 6, 2018 at 3:25 PM, Stefan Agner <stefan@agner.ch> wrote:

> Using of_device_get_match_data in imx7d_pinctrl_probe simplifies
> the function. Also get rid of the void pointer cast since
> imx_pinctrl_probe now accepts const struct imx_pinctrl_soc_info.
>
> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Patch applied.

Yours,
Linus Walleij

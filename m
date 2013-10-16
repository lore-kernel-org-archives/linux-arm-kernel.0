From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 Oct 2013 13:42:46 +0200
Subject: [PATCH v2 3/5] pinctrl: rockchip: remove redundant check
In-Reply-To: <201310160108.12261.heiko@sntech.de>
References: <201310160106.42329.heiko@sntech.de>
 <201310160108.12261.heiko@sntech.de>
Message-ID: <CACRpkdavaPzxf6vV6QFDr5uRZ1963Qk0ErVa3MdxfhfUf4oUCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 1:08 AM, Heiko St?bner <heiko@sntech.de> wrote:

> The check limiting bias options to supported ones is already
> done thru rockchip_pinconf_pull_valid. Therefore this check is
> redundant and can be removed.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Patch applied.

Yours,
Linus Walleij

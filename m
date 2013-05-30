From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 20:26:44 +0200
Subject: [PATCH 11/11] ARM: davinci: da850 evm: add GPIO DT data
In-Reply-To: <1369206634-6778-12-git-send-email-avinashphilip@ti.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
 <1369206634-6778-12-git-send-email-avinashphilip@ti.com>
Message-ID: <CACRpkdYOGj9SQepDyv3hCSXkQugNb_cwb3+KY0vixEZ7PT-nOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 9:10 AM, Philip Avinash <avinashphilip@ti.com> wrote:

> From: KV Sujith <sujithkv@ti.com>
>
> - Add GPIO DT Data and pinmux for DA850 EVM. GPIO is configurable differently
>   on different boards. So add GPIO pinmuxing in dts file.
> - Dependency: This patch is dependent on Grab-pin-control patch;
>   https://patchwork.kernel.org/patch/2013751/
>
> Signed-off-by: KV Sujith <sujithkv@ti.com>
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>

Looks fine to me, but Tony should review this.

Yours,
Linus Walleij

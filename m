From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Jan 2013 11:17:48 +0100
Subject: [PATCH 2/2] gpio: pca953x: use managed resources
In-Reply-To: <1359133168-14879-3-git-send-email-gregory.clement@free-electrons.com>
References: <1359133168-14879-1-git-send-email-gregory.clement@free-electrons.com>
 <1359133168-14879-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CACRpkdaEH+hqOo6i+4Lz+T4B+oAvCj+v0Ycr576yV2fWN2VNvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 25, 2013 at 5:59 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> Using the devm_* managed resources the pca driver can be simplified
> and cut down on boilerplate code.
>
> [gcl: fixed a inccorect reference to a removed label, "goto fail_out"
> became "return ret"]

Oh now "gcl" means both Grant C. Likely and Gregory CLement :-)

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Patch applied, thanks!

Yours,
Linus Walleij

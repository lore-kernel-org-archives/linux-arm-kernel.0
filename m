From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Jun 2017 11:20:18 +0200
Subject: [PATCH v3 2/9] pinctrl: mvebu: remove the offset property for
 regmap
In-Reply-To: <9cbcf3247ef2e18381c95645c73c31dade2c2ccb.1497281623.git-series.gregory.clement@free-electrons.com>
References: <cover.d003a5e862e6d732d901a61d1765a349c9a89eef.1497281623.git-series.gregory.clement@free-electrons.com>
 <9cbcf3247ef2e18381c95645c73c31dade2c2ccb.1497281623.git-series.gregory.clement@free-electrons.com>
Message-ID: <CACRpkdao=_01=iibeOh03r4QocAGVMh8zfHTKKWvrOnxxSGmZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 5:34 PM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> The offset property of the pinctrl node, when a regmap is used in the
> device tree, was never used nor documented in the binding. Moreover, the
> compatible string is enough to let the driver know which offset using.
>
> So this patch removes the property and move the information at the driver
> level.
>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Patch applied.

Yours,
Linus Walleij

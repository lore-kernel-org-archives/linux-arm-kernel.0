From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Mar 2013 01:45:34 +0100
Subject: [PATCH v2 2/3] ARM: dts: imx: replace magic number with pin
 function name
In-Reply-To: <1361533888-18073-3-git-send-email-shawn.guo@linaro.org>
References: <1361533888-18073-1-git-send-email-shawn.guo@linaro.org>
 <1361533888-18073-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdZOKrLy9-y4=vsayUt_PfVbYeN8mu5mnX2VUm60=JA=Cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 22, 2013 at 12:51 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> This turns the imx pin function number defined by binding document
> into #define constants in header which can be used in dts and handled
> by pre-processor to improve the readability of device tree sources.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

I agree and wanted this to be fixed all the time, so
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

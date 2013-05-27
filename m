From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 27 May 2013 12:41:04 +0200
Subject: [PATCH 7/7] Documentation: Update binding for Nomadik and DBx5x
 based platforms
In-Reply-To: <1369232581-18923-8-git-send-email-lee.jones@linaro.org>
References: <1369232581-18923-1-git-send-email-lee.jones@linaro.org>
 <1369232581-18923-8-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYyZZSy4VgFc+Uo=5iAF++EPmHM0U2pHcLdkDZc=Xb_sQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 4:23 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Change compatible string to something more standard.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/ste,nomadik.txt |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/ste,nomadik.txt b/Documentation/devicetree/bindings/pinctrl/ste,nomadik.txt
> index 9a2f3f4..c3d8a89 100644
> --- a/Documentation/devicetree/bindings/pinctrl/ste,nomadik.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/ste,nomadik.txt
> @@ -1,8 +1,8 @@
>  ST Ericsson Nomadik pinmux controller
>
>  Required properties:
> -- compatible: "stericsson,nmk-pinctrl", "stericsson,nmk-pinctrl-db8540",
> -              "stericsson,nmk-pinctrl-stn8815"
> +- compatible: "stericsson,db8500-pinctrl", "stericsson,db8540-pinctrl",
> +              "stericsson,stn8815-pinctrl"

OK...

>         pinctrl at 80157000 {
> -               compatible = "stericsson,nmk-pinctrl";
> +               compatible = "stericsson,u8500-pinctrl";

This does not look like a supported compatible string?

Yours,
Linus Walleij

From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 22 Jun 2018 09:59:56 +0200
Subject: [PATCH 7/7] dt-bindings: samsung: Document binding for SGH-T959P
 board
In-Reply-To: <1529608199-5583-8-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1529608199-5583-8-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <CAJKOXPffUmnms72vLDU9pEQCtpUCHir=5ae-vTPpS0wfmNut4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 June 2018 at 21:09, Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
>

Commit msg.

Best regards,
Krzysztof

> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> index edce6602de50..8a9358336aab 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> @@ -3,6 +3,7 @@
>  Required root node properties:
>      - compatible = should be one or more of the following.
>         - "samsung,aries"       - for S5PV210-based Samsung Aries board.
> +       - "samsung,fascinate4g" - for S5PV210-based Samsung Galaxy S Fascinate 4G (SGH-T959P) board.
>         - "samsung,galaxys"     - for S5PV210-based Samsung Galaxy S (i9000)  board.
>         - "samsung,artik5"      - for Exynos3250-based Samsung ARTIK5 module.
>         - "samsung,artik5-eval" - for Exynos3250-based Samsung ARTIK5 eval board.
> --
> 2.7.4
>

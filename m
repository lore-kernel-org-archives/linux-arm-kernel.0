From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 22 Jun 2018 09:56:41 +0200
Subject: [PATCH 5/7] dt-bindings: samsung: Document bindings for Samsung
 aries boards
In-Reply-To: <1529608199-5583-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1529608199-5583-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <CAJKOXPdV+UKKnntcrXQ15aOB5eCehyxqVEJfvZp5faTw434rPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 June 2018 at 21:09, Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote:
> Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> index 14510b215480..edce6602de50 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> @@ -2,6 +2,8 @@
>
>  Required root node properties:
>      - compatible = should be one or more of the following.
> +       - "samsung,aries"       - for S5PV210-based Samsung Aries board.
> +       - "samsung,galaxys"     - for S5PV210-based Samsung Galaxy S (i9000)  board.

It is not strictly speaking Exynos-based board (as mentioned in the
header at beginning of file) so maybe change it to "Samsung's Exynos
and S5P SoC based boards"?

Best regards,
Krzysztof

>         - "samsung,artik5"      - for Exynos3250-based Samsung ARTIK5 module.
>         - "samsung,artik5-eval" - for Exynos3250-based Samsung ARTIK5 eval board.
>         - "samsung,monk"        - for Exynos3250-based Samsung Simband board.
> --
> 2.7.4
>

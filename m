From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 28 Jun 2018 09:52:36 +0200
Subject: [PATCH v2 05/10] dt-bindings: samsung: Add S5PV210 as possible
 soc in Samsung boards
In-Reply-To: <1530119544-30023-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530119544-30023-6-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <CAJKOXPcZJWW49TL-eybV5486pnik0+-G9ByVg=b1iWbTJwAvAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 June 2018 at 19:12, Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote:
> There are Samsung devices, which are not Exynos-based boards,
> like it's in case of S5PV210. Document this information at beginning
> of file.
>
> Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> index 14510b215480..175f669d9bb6 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt
> @@ -1,4 +1,4 @@
> -* Samsung's Exynos SoC based boards
> +* Samsung's Exynos and S5P SoC based boards

At the point of this commit, there are no S5P boards mentioned. These
will be added with next commit so please just squash it with the next
one.

I saw that Rob reviewed your v1 after you sent v2, so don't forget to
include it in v3:
Reviewed-by: Rob Herring <robh@kernel.org>

Best regards,
Krzysztof

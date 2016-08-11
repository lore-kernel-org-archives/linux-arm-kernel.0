From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Aug 2016 13:52:04 +0200
Subject: [PATCH 03/11] pinctrl: nomadik: use of_property_read_bool
In-Reply-To: <1470387411-15879-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1470387411-15879-1-git-send-email-Julia.Lawall@lip6.fr>
 <1470387411-15879-4-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CACRpkdZi-dpkgvH5zR_UKiTbk4pmsGeiXH5pVgjZBrW2FaK1ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 5, 2016 at 10:56 AM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> Use of_property_read_bool to check for the existence of a property.
>
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @@
> expression e1,e2;
> statement S2,S1;
> @@
> -       if (of_get_property(e1,e2,NULL))
> +       if (of_property_read_bool(e1,e2))
>         S1 else S2
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Patch applied.

Yours,
Linus Walleij

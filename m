From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 29 Nov 2015 23:35:35 -0200
Subject: [PATCH] ARM: mxs: dt: cfa10057: fix backlight PWM
In-Reply-To: <1448846557-26594-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1448846557-26594-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <CAOMZO5CKZDx5djuUsXcNoB0deU_DhKSCn_m7E2=H3zSzi5X1Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 29, 2015 at 11:22 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

> -               default-brightness-level = <7>;
> +               default-brightness-level = <6>;

This one is an unrelated change.

From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 1 Jul 2013 18:47:00 -0300
Subject: [PATCH 3/3] ARM: dts: Add WM1811A audio CODEC to Arndale bindings
In-Reply-To: <1372714599-17588-3-git-send-email-broonie@kernel.org>
References: <1372714599-17588-1-git-send-email-broonie@kernel.org>
 <1372714599-17588-3-git-send-email-broonie@kernel.org>
Message-ID: <CAOMZO5DZb1wWu93eEHkEqNORhm_hn6qy_LdiRSumP7UODJ3uMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 1, 2013 at 6:36 PM, Mark Brown <broonie@kernel.org> wrote:

>         i2c at 12C90000 {
> -               status = "disabled";
> +               wm1811a at 11 {
> +                       compatible = "wlf,wm1811";
> +                       reg = <0x1a>;

Shouldn't it be reg = <0x11> ? Or wm1811a at 1a ?

From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Apr 2013 10:48:29 +0200
Subject: [PATCH] pinctrl: sunxi: Rename wemac functions to emac
In-Reply-To: <1364389953-20688-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1364389953-20688-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdbESJaYTAONN5UdDEUEVHjh3iJcfrXs2-g61MHi4FouVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 2:12 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> The pin functions associated to the ethernet controller were introduced
> with the label "wemac", which was the name of the ethernet driver in the
> allwinner source tree, while the real name of the IP is actually "emac",
> as advertised in several documents including the datasheet.
>
> Since this is part of the device tree bindings, and that these part of
> the bindings have not yet be released in a kernel version, it seems like
> the good timing to change it and assure consistency.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied, thanks!

Yours,
Linus Walleij

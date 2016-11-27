From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 27 Nov 2016 10:38:26 -0200
Subject: [PATCH 1/2] Documentation: sample averaging for imx6ul_tsc
In-Reply-To: <1480232698-23075-1-git-send-email-guy.shapiro@mobi-wize.com>
References: <1480232698-23075-1-git-send-email-guy.shapiro@mobi-wize.com>
Message-ID: <CAOMZO5Acpz_Y-MYcDmhDGg0eX=+d=mjruXAE+kZhK04rGgsG5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 27, 2016 at 5:44 AM, Guy Shapiro <guy.shapiro@mobi-wize.com> wrote:
> The i.MX6UL internal touchscreen controller contains an option to
> average upon samples. This feature reduces noise from the produced
> touch locations.
>
> This patch introduces a new device tree optional property for this
> feature. It provides control over the amount of averaged samples per
> touch event.
>
> The property was inspired by a similar property on the
> "brcm,iproc-touchscreen" binding.
>
> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

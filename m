From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 May 2012 10:44:54 +0200
Subject: [PATCH 2/2] pinctrl: mxs: skip gpio nodes for group creation
In-Reply-To: <1336922341-7089-3-git-send-email-shawn.guo@linaro.org>
References: <1336922341-7089-1-git-send-email-shawn.guo@linaro.org>
 <1336922341-7089-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdYj2-LH2DpdU+SxywfVf6ETfxr90P3-9XvU2JF+hOQ5LQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 13, 2012 at 5:19 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> The recent added mxs gpio device tree bindings require gpio nodes
> defined under pinctrl node too. ?The pinctrl-mxs driver should skip
> these node for group parsing and creating.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Thanks, applied!
Linus Walleij

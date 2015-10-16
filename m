From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Oct 2015 16:09:53 +0200
Subject: [PATCH 1/5] pinctrl: berlin: select the pinctrl driver according
 to the SoC used
In-Reply-To: <1444771901-24460-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1444771901-24460-1-git-send-email-antoine.tenart@free-electrons.com>
 <1444771901-24460-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <CACRpkdZ3Vx0+WwKuuV8keqK67Mf_pD22rwqg7WMO=1X0GwZqnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2015 at 11:31 PM, Antoine Tenart
<antoine.tenart@free-electrons.com> wrote:

> This patch prepares to remove the pinctrl driver selection from the
> mach-berlin Kconfig. To do so, bool is replaced by def_bool.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Patch applied with Sebastian's ACK.

Yours,
Linus Walleij

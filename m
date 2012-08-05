From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 5 Aug 2012 11:49:40 +0200
Subject: [PATCH 4/4] ARM: dts: imx: add alias for gpio
In-Reply-To: <1344146488-9496-4-git-send-email-shawn.guo@linaro.org>
References: <1344146488-9496-1-git-send-email-shawn.guo@linaro.org>
 <1344146488-9496-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdYVu2RyiOF7tr0jECeFpU1=mhRvQ5aMY-khuH_g2cDT8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 5, 2012 at 8:01 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> Add alias for gpio nodes, so that gpio driver can identify the port
> number and then specify a sensible gpio base rather than using the
> one dynamically allocated by gpio core.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Applied.

Thanks,
Linus Walleij

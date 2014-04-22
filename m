From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 13:39:24 +0200
Subject: [PATCH v3 1/7] pinctrl: sunxi: check clk_prepare_enable return
 value
In-Reply-To: <1397137966-30818-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1397137966-30818-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397137966-30818-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <CACRpkdZrf-rrPUVc-rhH1_ovYnRKbg5+D76EM_wG2A3Xpfj5OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 3:52 PM, Boris BREZILLON
<boris.brezillon@free-electrons.com> wrote:

> Check the clk_prepare_enable return value to avoid false positive probe.
>
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij

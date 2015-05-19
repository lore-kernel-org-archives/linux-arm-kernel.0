From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 May 2015 11:01:26 +0200
Subject: [PATCH 09/10] pinctrl: mediatek: add pinctrl/GPIO/EINT driver for
 mt8127
In-Reply-To: <1431567346-33780-10-git-send-email-hongzhou.yang@mediatek.com>
References: <1431567346-33780-1-git-send-email-hongzhou.yang@mediatek.com>
 <1431567346-33780-10-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <CACRpkdZL=U2R3q2iC6BOvDw7DTb7-vg6z1Tieyd2aQy5t+vq9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 3:35 AM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> From: Yingjoe Chen <yingjoe.chen@mediatek.com>
>
> MT8127 pinctrl/eint are similar to mt8135 and mt8173, add
> support for mt8127 using mediatek common pinctrl driver.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>

Patch applied. Needed some fuzzing in the Makefile,
check result in my devel branch or linux-next.

Yours,
Linus Walleikj

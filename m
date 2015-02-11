From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Feb 2015 22:45:58 +0800
Subject: [PATCH v5 3/5] ARM: mediatek: Add Pinctrl/GPIO driver for mt8135.
In-Reply-To: <1423644176.1967.12.camel@mussux00.eus.mediatek.inc>
References: <1421818097-9281-1-git-send-email-hongzhou.yang@mediatek.com>
 <1421818097-9281-4-git-send-email-hongzhou.yang@mediatek.com>
 <CACRpkdasVPUtn=-DhJ4OUXGZh36sLKwLhvm-nD-mkZjP7gQXww@mail.gmail.com>
 <1423644176.1967.12.camel@mussux00.eus.mediatek.inc>
Message-ID: <CACRpkdYsxcF_VdX7VDvaGcashPj=A518aKE8eKxhcUmuOKejLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 11, 2015 at 4:42 PM, Hongzhou Yang
<hongzhou.yang@mediatek.com> wrote:

> Due to pinconf relate API changed at kernel-3.20, a build error
> happened.
> Do I need to send patch v6?

I discussed with your colleagues and I think it's simplest just to make
a small fix patch on top of what is found on the mtk-staging branch
and I'll apply it there.

Yours,
Linus Walleij

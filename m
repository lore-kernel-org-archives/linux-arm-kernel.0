From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Aug 2014 09:29:23 +0200
Subject: [PATCH 3/3] pinctrl: single: AM437x: Add pinctrl compatibility
In-Reply-To: <1408716062-26055-4-git-send-email-nm@ti.com>
References: <1408716062-26055-1-git-send-email-nm@ti.com>
 <1408716062-26055-4-git-send-email-nm@ti.com>
Message-ID: <CACRpkdZzfN7VQipTUKzfc-W5N4NSTxSou+aagBVh4so=X8gi-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 22, 2014 at 4:01 PM, Nishanth Menon <nm@ti.com> wrote:

> From: Keerthy <j-keerthy@ti.com>
>
> AM437x pinctrl definitions now differ from traditional 16 bit OMAP pin
> ctrl definitions, in that all 32 bits are used to describe a single pin
>
> Also the location of wakeupenable and event bits have changed.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> [nm at ti.com: minor updates]
> Signed-off-by: Nishanth Menon <nm@ti.com>

Patch applied with Tony's ACK.

Yours,
Linus Walleij

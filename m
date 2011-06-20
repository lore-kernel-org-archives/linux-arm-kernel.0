From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Jun 2011 21:34:00 +0200
Subject: [PATCH 0/3] Improve MMC error handling (3rd rev)
In-Reply-To: <20110620190945.GK26089@n2100.arm.linux.org.uk>
References: <20110620190945.GK26089@n2100.arm.linux.org.uk>
Message-ID: <BANLkTi=K2iV+7QLuu=QMgh+V=xBUxmULdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 9:09 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> This is the third revision of my improvements to the MMC block
> device error handling, which makes error handling more robust
> and permits MMC/SD to continue working in the presence of
> not-quite-perfect setups.

All look like perfectly reasonable hardening of the MMC error
path, so FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij

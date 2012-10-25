From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 25 Oct 2012 09:04:46 +0200
Subject: [PATCH 4/5] ARM: Dove: Make use of pinctrl driver
In-Reply-To: <1351088724-11142-5-git-send-email-andrew@lunn.ch>
References: <1351088724-11142-1-git-send-email-andrew@lunn.ch>
 <1351088724-11142-5-git-send-email-andrew@lunn.ch>
Message-ID: <CACRpkdb5-Cz5-j=Grjc90dFfzTXPONZSKC8g3qm_hs+yUQef4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2012 at 4:25 PM, Andrew Lunn <andrew@lunn.ch> wrote:

>         select PLAT_ORION_LEGACY
> +       select PINCTRL
> +       select PINCTRL_DOVE

Sort alphanumeric.

Yours,
Linus Walleij

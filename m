From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 5 Sep 2012 10:31:33 +0200
Subject: [PATCH 2/5] Documentation: add description of DT binding for the
 gpio-mvebu driver
In-Reply-To: <CAOesGMjqX8emWW5ie6fdstA3Oo9BYTM0wcD4Pjo1J+Obm6Xx1w@mail.gmail.com>
References: <1344691906-15985-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1344691906-15985-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20120827215133.GA7431@lumpy>
 <CACRpkda=BHEWLx3q7kv_SSxg5j2=KTE_1ga4uNDxUx0M3_nm1g@mail.gmail.com>
 <CAOesGMjqX8emWW5ie6fdstA3Oo9BYTM0wcD4Pjo1J+Obm6Xx1w@mail.gmail.com>
Message-ID: <CACRpkdYgJ7ydTCNZMrGzAYT7606kBypZDtTY8vgezPa=W2X=SQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 5, 2012 at 6:51 AM, Olof Johansson <olof@lixom.net> wrote:

> I guess it doesn't hurt to add the flag since it might be used on
> other OSes that have a gpio driver but not a pinctrl one, but that's a
> pretty far corner case, no need to revise for it.

Sounds a bit ambigous and redundant, as we are in the driver
seat for device tree I'd prefer to force every other OS to get their
pinctrl concepts right ;-)

Linus Walleij

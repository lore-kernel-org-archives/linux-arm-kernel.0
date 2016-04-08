From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 8 Apr 2016 13:14:46 +0200
Subject: [PATCH v3 12/18] dt-bindings: Add PLX Technology OXNAS pinctrl
 and gpio bindings
In-Reply-To: <CAL_JsqLsKEb+dWLg9VD3p=kjgEV84_r8z89p0QgMJWKqjrGNpw@mail.gmail.com>
References: <1458838215-23314-1-git-send-email-narmstrong@baylibre.com>
 <1458838215-23314-13-git-send-email-narmstrong@baylibre.com>
 <20160325144834.GA27177@rob-hp-laptop>
 <CACRpkdbem5a_aLTHErp0ZvanwvVPbGnDiWxM5e7iX_FdHtXprQ@mail.gmail.com>
 <CAL_JsqLsKEb+dWLg9VD3p=kjgEV84_r8z89p0QgMJWKqjrGNpw@mail.gmail.com>
Message-ID: <CACRpkdbHdMG6PLxs-37kdyM55qye2igxdgHMxn3fUaoEaRdU+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 3:36 PM, Rob Herring <robh@kernel.org> wrote:

> Looking at one example, it appears to be redundant already.
> nomadik-gpio-chips property already gives you the index. The index of
> the phandles is the bank numbering. PIC32 could do the same.

nomadik-gpio-chips is a property on the pin controller,
so it goes the wrong direction I think, the pin controller
knows these indexes but the GPIO chip does not know
what index it has.

Yours,
Linus Walleij

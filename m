From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Jun 2018 11:03:22 +0200
Subject: [PATCH 0/5] RFC: Mezzanine handling for 96boards
In-Reply-To: <174ecf08-7665-8183-07b4-790bdfcf5662@gmail.com>
References: <20180618074556.6944-1-linus.walleij@linaro.org>
 <CAL_JsqK2DKPbaFvUPSU2E7oh1_pryrRXPMg8OASmK722jmznwA@mail.gmail.com>
 <174ecf08-7665-8183-07b4-790bdfcf5662@gmail.com>
Message-ID: <CACRpkdbEqcdHeLMbM-3eMv-cRUo=17DaqwWMm2HX0vENt3Ku6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2018 at 3:02 PM Frank Rowand <frowand.list@gmail.com> wrote:

> Agreeing with Rob (despite my other reply asking why the current
> devicetree mechanisms can't be used)

I think I answer also your comments in my reply to Rob,
please check!

> that we do have a desire to
> have the ability to create bindings for connectors - this has been
> discussed before.

Let's create bindings for connectors.

But I have this caveat: let's create a binding for connectors
that does not stipulate that its children must be populated
using overlays, but could optionally be bound to driver that
populate the children any way the OS want to do this.

Yours,
Linus Walleij

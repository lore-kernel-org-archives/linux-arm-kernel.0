From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Feb 2013 17:37:34 +0100
Subject: [PATCHv2 0/3] Add support for user LED on the A13-Olinuxino
In-Reply-To: <1359889813-10029-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1359889813-10029-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CACRpkdZRN6ieCEbQJtHEBn0_eak_7GJ1SLHzqPJ6DQNPSCaE_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 3, 2013 at 12:10 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:

> To do so, we also add a custom of_xlate function to the PIO driver so that
> we can use a more convenient format for the gpios from the device tree.

This is now merged.

> Linus, since you took the dt changes for the pinctrl driver in your tree, maybe you could merge
> the two first patches, the second patch depending on patches in
> your tree.

Patch 2/3 does not apply to my tree. You must have something
more in your tree.

Actually I'm the kind of guy who thinks that DT stuff is better off
merged on it's own. In theory that stuff will one day be in its
own git and then we cannot rely on the application order of
changes to device trees vis-a-vis changes to code.

So for my part, just merge the DT stuff wherever you like
as long as there are no conflicts, Acked-by.

Yours,
Linus Walleij

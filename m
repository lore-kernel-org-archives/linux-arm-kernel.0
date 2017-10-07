From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 7 Oct 2017 12:54:25 +0200
Subject: [PATCH 0/7] gpio: brcmstb: improved interrupt and wake support
In-Reply-To: <20170930034057.15166-1-opendmb@gmail.com>
References: <20170930034057.15166-1-opendmb@gmail.com>
Message-ID: <CACRpkdYrYxi4ZNWvPVNr=w+QobQheDdgjUL0qLrAM+9t1-dd3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 30, 2017 at 5:40 AM, Doug Berger <opendmb@gmail.com> wrote:

> This patch set collects a number of improvements to the GPIO driver
> used by Broadcom Set-Top-Box devices.
>
> Primarily they are aimed at correcting problems with the interrupt
> controller implementation, but they also extend the functionality for
> waking on GPIO interrupts.

I saw there was some mention of a v2 patch set inline, so I
backed out the applied patch.

Please send the v2 series and collect the ACKs from Gregory
and Florian so I can apply it all!

Yours,
Linus Walleij

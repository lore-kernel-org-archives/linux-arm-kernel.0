From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Tue, 10 Nov 2015 09:50:00 +0100
Subject: Minimal support for dm814x
In-Reply-To: <20151109150602.GR3199@atomide.com>
References: <4999BB3D-4BB5-4F7C-96D7-FB687725CDCC@audioscience.com>
 <20151109150602.GR3199@atomide.com>
Message-ID: <CAALWOA-NUyRYaGbmBZpc6CcFga8_BKPZ9WQTxa3t09bHS_6=qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 November 2015 at 16:06, Tony Lindgren <tony@atomide.com> wrote:
> The PLL support is still missing, so it relies on the bootloader
> configured PLL values for now. I'm hoping to post PLL support patches over
> next few weeks and then we can have that and more devices working for v4.5.

Ah, yes, configuring a DPLL-LJ is fun.. figuring out how to write the
desired ratio as M/(M2*(1+N)) while simultaneously satisfying all
constraints on M, N, M2, refclk, and dco. :-)

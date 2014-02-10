From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Feb 2014 10:19:06 +0100
Subject: [PATCH 02/03] pinctrl: sh-pfc: r8a7790: Break out USB0 OVC/VBUS
In-Reply-To: <20140129231019.22655.41456.sendpatchset@w520>
References: <20140129230959.22655.55645.sendpatchset@w520>
 <20140129231019.22655.41456.sendpatchset@w520>
Message-ID: <CACRpkdahqPsFecErnLX_g=TaDzXA-AXZ-ghBZ=pffjDB7xVtOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 12:10 AM, Magnus Damm <magnus.damm@gmail.com> wrote:

> From: Magnus Damm <damm@opensource.se>
>
> Create a new group for the USB0 OVC/VBUS pin by itself. This
> allows us to monitor PWEN as GPIO on the Lager board.
>
> Signed-off-by: Magnus Damm <damm@opensource.se>

Patch applied with Laurent's and Simon's ACKs.

Yours,
Linus Walleij

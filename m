From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 4 Jul 2014 17:59:35 +0100
Subject: [RFC PATCH] tty: serial: Add 8250-core based omap driver
In-Reply-To: <20140702190944.GA567@drone.musicnaut.iki.fi>
References: <1404316809-20637-1-git-send-email-bigeasy@linutronix.de>
 <20140702160932.GF5541@saruman.home>
 <20140702190944.GA567@drone.musicnaut.iki.fi>
Message-ID: <CAFEAcA-UyLWteuNUO1xa5cGvQQV-fscJtiaC7B6N=cdTam-UQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 July 2014 20:09, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> When ttyS -> ttyO change was done on OMAP, compatibility was not an issue.
> Why should we care about it now?

You should have cared about it back then as well -- it was
really annoying and required everybody running an OMAP
based board to suddenly fix up their userland and command
line configs when they got broken by a kernel upgrade.

thanks
-- PMM

From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Jan 2013 15:50:34 +0100
Subject: [PATCH 0/4] add ux500_wdt support
In-Reply-To: <1358509214-22407-1-git-send-email-fabio.baltieri@linaro.org>
References: <1358509214-22407-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkdY-VChUeSsb8QppnVjj46EnQ=zv5cWnphoRvZveAvEeDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 12:40 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> this set adds support for the ux500_wdt timer, implemented in the PRCMU
> unit of ST-Ericsson ux500 architecture.
>
> The first two patches add the necessary definitions and function export
> to the PRCMU driver currently in mainline, while the third an fourth
> patches add the actual watchdog driver and mfd_cell definition to make
> it probe when PRCMU is compiled in.
>
> As the patches touches files in both mfd and watchdog subsystems, what do
> you think is the best way to handle this set?

Acked-by: Linus Walleij <linus.walleij@linaro.org>

As the majority touch the MFD parts, can Wim ack this so Sam can
take it through the MFD tree?

Yours,
Linus Walleij

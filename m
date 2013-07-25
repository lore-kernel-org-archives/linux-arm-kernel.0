From: marex@denx.de (Marek Vasut)
Date: Thu, 25 Jul 2013 08:05:41 +0200
Subject: [PATCH v12 00/13] Add tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
Message-ID: <201307250805.41238.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter Chen,

> This patchset adds tested otg id switch function and
> vbus connect and disconnect detection for chipidea driver.
> And fix kinds of bugs found at chipidea drivers after enabling
> id and vbus detection.
> 
> This patch is fully tested at imx6 sabresd platform.
> My chipidea repo: https://github.com/hzpeterchen/linux-usb.git

Patchset:

Tested-by: Marek Vasut <marex@denx.de>

on two STMP3780-based boards (not yet mainline) and two MX28-based boards.

Best regards,
Marek Vasut

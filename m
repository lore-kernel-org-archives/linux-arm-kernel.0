From: hector.palacios@digi.com (Hector Palacios)
Date: Mon, 26 Aug 2013 18:24:48 +0200
Subject: [PATCH v15 00/13] Add tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
References: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
Message-ID: <521B8150.70906@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Peter,

On 08/12/2013 03:22 AM, Peter Chen wrote:
> This patchset adds tested otg id switch function and vbus connect
> and disconnect detection for chipidea driver. And fix kinds of
> bugs found at chipidea drivers after enabling id and vbus detection.
>
> This patch are fully tested at imx6 sabresd and imx28evk platform by me.
> Besides, marek tested it on two STMP3780-based boards (not yet mainline)
> and two MX28-based boards.
>
> My chipidea repo: https://github.com/hzpeterchen/linux-usb.git
>
> Changes for v15:
> - Mark otgsc API as static line, and move them to otg.h [4/13]
> - Remove some redundant comments [6/13]
> - Fix some typos [8/13]
> - Retire flag CI_HDRC_PULLUP_ON_VBUS [12/13] [13/13]

Patches 6 and 12 in this series seem to be incomplete or malformed. Please check.

Best regards,
--
Hector Palacios

From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 27 Aug 2013 10:51:16 +0800
Subject: [PATCH v15 00/13] Add tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <521B8150.70906@digi.com>
References: <1376270579-13493-1-git-send-email-peter.chen@freescale.com>
 <521B8150.70906@digi.com>
Message-ID: <20130827025115.GA6561@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 26, 2013 at 06:24:48PM +0200, Hector Palacios wrote:
> Dear Peter,
> 
> On 08/12/2013 03:22 AM, Peter Chen wrote:
> >This patchset adds tested otg id switch function and vbus connect
> >and disconnect detection for chipidea driver. And fix kinds of
> >bugs found at chipidea drivers after enabling id and vbus detection.
> >
> >This patch are fully tested at imx6 sabresd and imx28evk platform by me.
> >Besides, marek tested it on two STMP3780-based boards (not yet mainline)
> >and two MX28-based boards.
> >
> >My chipidea repo: https://github.com/hzpeterchen/linux-usb.git
> >
> >Changes for v15:
> >- Mark otgsc API as static line, and move them to otg.h [4/13]
> >- Remove some redundant comments [6/13]
> >- Fix some typos [8/13]
> >- Retire flag CI_HDRC_PULLUP_ON_VBUS [12/13] [13/13]
> 
> Patches 6 and 12 in this series seem to be incomplete or malformed. Please check.
> 

Would you post what's the problem for them or what's problem
at your system after using them?

-- 

Best Regards,
Peter Chen

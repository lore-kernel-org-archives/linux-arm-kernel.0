From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 29 Jul 2015 12:19:46 +0200
Subject: [PATCH 07/10] usb: chipidea: usbmisc_imx: add unburst setting
 for imx6
In-Reply-To: <20150729075728.GC27605@shlinux2>
References: <1438137734-27311-1-git-send-email-peter.chen@freescale.com>
 <1438137734-27311-8-git-send-email-peter.chen@freescale.com>
 <20150729103022.7cfe0466@ipc1.ka-ro>
 <20150729075728.GC27605@shlinux2>
Message-ID: <20150729121946.009e7f03@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Wed, Jul 29, 2015 at 10:30:22AM +0200, Lothar Wa?mann wrote:
> > Hi,
> > 
> > > With this setting and AHBBRST at SBUSCFG as "Incremental burst of
> > > unspecified length", each unburst size can be taken as one single transfer.
> > > It is benefit for unburst size transfer.
> > > 
> > What is an 'unburst'?
> > 
> 
> Assume burst size is 8 dword, unburst size 't' < 8.
> 
> With this feature, 't' length payload can be taken
> as one burst transfer, otherwise, the single transfer
> (1 dword) will be used.
> 
IMO non-burst would be a better word.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

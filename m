From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 18 Nov 2011 09:29:55 +0100
Subject: [alsa-devel] [PATCH v5 1/3] ARM: mxs: add saif clkmux functions
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7722E47BC@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1321003855-13430-1-git-send-email-b29396@freescale.com>
 <1321003855-13430-2-git-send-email-b29396@freescale.com>
 <201111180554.42242.marek.vasut@gmail.com>
 <65EE16ACC360FA4D99C96DC085B3F7722E47BC@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20166.6019.921262.50184@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dong Aisheng-B29396 writes:
[...]
> > > +#define HW_DIGCTL_CTRL			0x0
> > > +#define  BP_DIGCTL_CTRL_SAIF_CLKMUX	(10)
> > 
> > Do you need the parenthesis above ?
> > 
> I'm not sure about his.
> HW_DIGCTL_CTRL is the register offset.
> Do we have to do this?
> 
You need parens around macro parameters that are used in an expression
inside the macro. But you never ever need to enclose a bare number in
parens!


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Wed, 18 Dec 2013 09:30:46 +0100
Subject: [PATCH 4/4] cpufreq: imx6q: correct VDDSOC/PU voltage scaling
 when cpufreq is changed
In-Reply-To: <20131217121358.GM6691@S2101-09.ap.freescale.net>
References: <1387228450-641-1-git-send-email-b20788@freescale.com>
 <1387228450-641-2-git-send-email-b20788@freescale.com>
 <20131217025616.GC6691@S2101-09.ap.freescale.net>
 <20131217105347.75954ad3@ipc1.ka-ro>
 <20131217121358.GM6691@S2101-09.ap.freescale.net>
Message-ID: <20131218093046.6d439329@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Shawn Guo wrote:
> On Tue, Dec 17, 2013 at 10:53:47AM +0100, Lothar Wa?mann wrote:
> > > > +	if (soc_opp_index >= soc_opp_count) {
> > > 
> > > Can soc_opp_index be possibly greater than soc_opp_count?  Otherwise,
> > > the condition check below is good enough?
> > > 
> > > 	if (soc_opp_index == soc_opp_count)
> > >
> > it doen't harm to be on the safe side and use >= anyway!
> 
> Well, it may confuse reader.  At least, it took me some time understand
> how that ">" condition will happen.  And it turns out never.
> 
man "defensive programming"


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________

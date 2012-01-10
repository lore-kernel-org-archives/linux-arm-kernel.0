From: rusko.peter@prolan.hu (Peter Rusko)
Date: Tue, 10 Jan 2012 14:08:31 +0100
Subject: MX28 fec clock frequency
In-Reply-To: <20120110082138.GF23362@S2101-09.ap.freescale.net>
References: <4F06D643.6080602@prolan.hu>
 <20120108033238.GA19721@S2101-09.ap.freescale.net>
 <4F0AF4B0.4030403@prolan.hu>
 <20120110082138.GF23362@S2101-09.ap.freescale.net>
Message-ID: <4F0C384F.10706@prolan.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I'm not sure it's causing the problem you are seeing.  But from i.MX28
> spec, it seems that bit BUSY_TIME of register HW_CLKCTRL_ENET should
> be polled for new divider setting?
>

Thank you, I've added the check, but unfortunately it didn't help :(

-- 
Rusk? P?ter
Fejleszt?m?rn?k

Prolan Zrt. / Prolan Co.
Hungary 2011 Budakal?sz, Szentendrei ?t 1-3.
Tel./Phone: +36 20 954 3118
Fax: +36 26 540 420
E-mail: rusko.peter at prolan.hu
Web: www.prolan.hu
Timezone:CET

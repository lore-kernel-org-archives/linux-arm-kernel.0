From: rusko.peter@prolan.hu (Peter Rusko)
Date: Tue, 10 Jan 2012 16:39:37 +0100
Subject: MX28 fec clock frequency
In-Reply-To: <20120110140043.GC26599@S2101-09.ap.freescale.net>
References: <4F06D643.6080602@prolan.hu>
 <20120108033238.GA19721@S2101-09.ap.freescale.net>
 <4F0AF4B0.4030403@prolan.hu>
 <20120110082138.GF23362@S2101-09.ap.freescale.net> <4F0C384F.10706@prolan.hu>
 <20120110140043.GC26599@S2101-09.ap.freescale.net>
Message-ID: <4F0C5BB9.3070203@prolan.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2012-01-10 15:00, Shawn Guo wrote:
> Another point worth checking is bit field ATIME_INC of register
> HW_ENET_MAC_ATIME_INC.  It should be 25 if your CLK_ENET_TIME runs
> at 40 MHz.
>

No, that was set correctly. Finally, I've found my mistake. I've 
overwritten the other bits when writing the divider so xtal clock was 
selected automatically.
Silly little mistake, isn't it? :) Anyway, thank you for your help.

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

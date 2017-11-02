From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Nov 2017 15:48:14 +0000
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <SG2PR06MB116563CB4F1B55160392AAC68A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20171031182024.GK9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311432120.21665@knanqh.ubzr>
 <SG2PR06MB1165AE45FB289039E55D03028A5E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102000945.GT9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1711012249020.21665@knanqh.ubzr>
 <SG2PR06MB11655BDEF09BB62D268A29DD8A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102112041.GW9463@n2100.armlinux.org.uk>
 <SG2PR06MB11653D39086B1F58497C9FE08A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1711021044380.21665@knanqh.ubzr>
 <SG2PR06MB116563CB4F1B55160392AAC68A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Message-ID: <20171102154814.GE9463@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 02, 2017 at 03:23:14PM +0000, Chris Brandt wrote:
> On Thursday, November 02, 2017 1, Nicolas Pitre wrote:
> > > > So, as far as ARM assembly in the Linux kernel goes, all constants
> > must
> > > > be preceded by # whether or not binutils requires it - no exceptions.
> > > > Please always test assembly changes with a binutils version that is
> > not
> > > > gratuitously broken!
> > >
> > > Somewhat ironic since Nicolas works for Linaro.
> > 
> > I'm not involved with the toolchain people though, other than using
> > their output.
> 
> That was the irony!
> 
> As in...
> Even if you built the code, you would have probably used a Linaro 
> toolchain and it would have worked like on my system.
> 
>   Forget it.  (mailing lists are so dry when it comes to humor)

It's not mailing lists, it's email.  Email lacks the facial expressions,
and the voice inflections and tone necessary to convey this extra
"metadata".  It's a well known problem.  Email is dry and devoid of the
subtle hints that humans need to effectively communicate.  Communication
is *not* just about the words on a page.

It's why we have smilies and emojis, as an attempt to fill that void, but
I bet most of us (me included) don't use them enough.

	http://www.youmeworks.com/no_honking.html

The 44% figure in that URL, if correct, is shocking.  It probably means
that approaching half of all emails on this list are misconstrued by
the reader(s) of them!

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up

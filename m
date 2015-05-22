From: ydroneaud@opteya.com (Yann Droneaud)
Date: Fri, 22 May 2015 21:27:12 +0200
Subject: Device Tree Blob (DTB) licence
In-Reply-To: <1432289148.5304.58.camel@opteya.com>
References: <1430820315.19516.26.camel@opteya.com>
 <CAL_Jsq+T5c7qornpRVCduEjUSCeM+0xqbtVYovtH76y=4BqhLQ@mail.gmail.com>
 <1432289148.5304.58.camel@opteya.com>
Message-ID: <1432322832.5304.63.camel@opteya.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[removing Cc: licensing at fsf.org]

Le vendredi 22 mai 2015 ? 12:05 +0200, Yann Droneaud a ?crit :
> Le mardi 05 mai 2015 ? 11:41 -0500, Rob Herring a ?crit :
> > On Tue, May 5, 2015 at 5:05 AM, Yann Droneaud <ydroneaud@opteya.com
> > > 
> > wrote:
> > > 
> > > I believe Device Tree Blob (.dtb file) built from kernel's Device 
> > > 
> > > Tree
> > > Sources (.dts, which #include .dtsi, which #include .h) using 
> > > Device
> > > Tree Compiler (dtc) are covered by GNU General Public Licence v2
> > > (GPLv2), but cannot find any reference.
> > 
> > By default yes, but we've been steering people to dual license them 
> > 
> > GPL/BSD.
> > 
> 
> Can you give me the rationale behind such dual licenses requirement ?
> 
> If a BSD .dts includes GPLv2 .h, the whole is covered by GPLv2,
> so I cannot find a case where a BSD covered .dts file could be used
> alone within BSD license rights.
> 
> > > As most .dtsi in arch/arm/boot/dts/ are covered by GPLv2, and,
> > > as most .h in include/dt-bindings/ are also covered by GPLv2,
> > > the source code is likely covered by GPLv2.
> > > 
> > > Then this source code is translated in a different language 
> > > (flattened
> > > device tree), so the resulting translation is also likely covered 
> > > 
> > > by
> > > GPLv2.
> > > 
> > > So, when I'm proposed to download a .dtb file from a random 
> > > vendor,
> > > can I require to get the associated source code ?
> > 
> > I believe so yes. However, you already have the "source" for the 
> > most
> > part. Just run "dtc -I dtb -O dts <dtb file>". You loose the
> > preprocessing and include structure though (not necessarily a bad
> > thing IMO).
> > 
> > Then the question is what is the license on that generated dts!
> > 
> 
> That's also a good question.
> 
> Is this a form a "reverse engineering" with all the legalese burden ?
> 
> Anyway without a clear information attached to the DTB, it's 
> difficult
> to tell which licence cover the "decompiled" version.
> 
> > > Anyway, for a .dtb file generated from kernel sources, it's 
> > > rather
> > > painful to look after all .dts, .dtsi, .h, to find what kind of
> > > licences are applicables, as some are covered by BSD, dual 
> > > licensed
> > > (any combination of X11, MIT, BSD, GPLv2).
> > 
> > I imagine the includes cause some licensing discrepancies if you 
> > dug 
> > into it.
> > 
> 
> It's a pity, and it's probably something to sort out.
> 
> DTB files produced as part of kernel compilation should have a well
> known license attached by default.
> 

I've added licensing at fsf.ogrg in Cc: in my previous message to have an 
advice on this subject, but I failed to notice licensing at fsf.org 
is not a mailing list: I was assigned request ID [gnu.org #1017262].

Regards.

-- 
Yann Droneaud
OPTEYA
-------------- next part --------------
An embedded message was scrubbed...
From: "FSF Licensing Questions via RT" <licensing@fsf.org>
Subject: [gnu.org #1017262] AutoReply concerning licensing question: Re: Device Tree Blob (DTB) licence 
Date: Fri, 22 May 2015 06:06:16 -0400
Size: 3989
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150522/11d8d5e6/attachment.mht>

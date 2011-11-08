From: vince@kyllikki.org (Vincent Sanders)
Date: Tue, 8 Nov 2011 14:53:23 +0000
Subject: Error for machine_is_m28evk
In-Reply-To: <20111108140557.GC10538@mudshark.cambridge.arm.com>
References: <CAOMZO5C4=ELWef8keoT8u0H8jTPRGQ5BA_8xYyKge++s+wdNqw@mail.gmail.com>
 <4EB8CC7B.5060503@denx.de> <20111108075349.GK2854@pengutronix.de>
 <CAB4PhKeKdGLa74W-n1DNbUcszWMf3nymqqhuzdZoj_oQG+YNsg@mail.gmail.com>
 <20111108085350.GX12913@n2100.arm.linux.org.uk>
 <20111108125346.GA7563@S2100-06.ap.freescale.net>
 <20111108133744.GE12913@n2100.arm.linux.org.uk>
 <20111108140557.GC10538@mudshark.cambridge.arm.com>
Message-ID: <20111108145322.GE856@kyllikki.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 02:05:58PM +0000, Will Deacon wrote:
> On Tue, Nov 08, 2011 at 01:37:44PM +0000, Russell King - ARM Linux wrote:
> > (b) with the loss of facilities like kautobuild (no one noticed for six
> >     months that simtec had shut it down...), we have lost any kind of
> >     automated detection for these kinds of issues.
> 
> Have Simtec /actually/ shut this down, or did it just die when kernel.org
> was hacked and nobody has poked it since then?
> 
> The website is still up and doesn't seem to mention its demise:
> 
> http://armlinux.simtec.co.uk/kautobuild/
> 
> Will

Simtec never really owned this it was more they sponsored the server
space and my time to run it. My employer have been very good and were
willing to keep paying for it but in the end it was my decision to
shut it down.

I posted the five year review some time ago and except for several
fairly abusive mails including that I should stop upsetting developers
by showing when things failed and several more *demands* that I
implemented additional features I received no feedback. With the
notable exception of Russell who was supportive.

As there were a grand total of four people subscribed to the results
list and the number of pageviews per month was under the hundred mark
I simply stopped the cron jobs in May and turned it off. I figured if
anyone really cared they would shout.

No one noticed until Russell mentioned it on IRC the other day so I am
fairly sure that me compiling 200+ default configs two or three times
a day was completely pointless as no one was looking at the
results. Even the yearly reports I wrote seemed to upset more people
than they helped.

My point of view is that the ARM "community" and the majority of
maintainers only care about the SoC and board they are working on
right that moment and once it is in mainline (well for a long time
that read "once the patches were posted to the mailing list") it can be
abandoned to Russell and janitors like myself. 

There were of course always exceptions to the rule and I know there is
great effort to improve the situation now. However it seems to me that
kautobuild providing build coverage was simply not useful in those
efforts. 

I continue to provide list moderation and work in other areas of ARM
Linux but I do not think my time was best spent maintaining (at not
inconsiderable personal expense) the kautobuilder system,

-- 
Regards Vincent
http://www.kyllikki.org/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 190 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111108/6b012f38/attachment.sig>

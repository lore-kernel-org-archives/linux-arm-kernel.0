From: schindele@nentec.de (Juergen Schindele)
Date: Fri, 27 Nov 2009 10:21:34 +0200
Subject: IXP425: help on HSS channelized service
In-Reply-To: <m3y6ltt6ru.fsf@intrepid.localdomain>
References: <4B0BDFC1.7010506@kaskonetworks.it>
	<200911261543.08448.schindele@nentec.de>
	<m3y6ltt6ru.fsf@intrepid.localdomain>
Message-ID: <200911270921.35517.schindele@nentec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 26. November 2009 schrieb Krzysztof Halasa:
> Juergen Schindele <schindele@nentec.de> writes:
> 
> >> The buffers have different structures for RX and TX.
> > This was a very good hint :-). I discovered that the 
> > "struct desc" used in the kernel mainline driver is quite 
> > different from the one used in INTEL code !?????.
> 
> Actually I meant the structures for channelized I/O RX and TX.
> 
> > When I replace the "struct desc" (see below) it works fine for me.
> > Isn't there a general problem with this driver when it works only 
> > for channelized mode (your case) ???
> 
> It most certainly works in packetized (HDLC) mode.
> 
> Perhaps you're using IXP46x/43x CPU and the new firmware (3.x)?
> The driver works with fw 2.4 (and some older), i.e. the last firmware
> which works with IXP42x and 46x/43x.
Thanks for your info. I thing thats the problem about it. I am using 
an 2.0 firmware from INTEL and that could be the problem.
Investigating......

--------------------------------------------------------------
J?rgen Schindele  
Software-Entwicklung

NENTEC Netzwerktechnologie GmbH
Greschbachstr. 12
76229 Karlsruhe
Deutschland
Telefon: +49 721 94249-51
Telefax: +49 721 94249-10
E-Mail:  schindele at nentec.de
WEB:     www.nentec.de
 
Gesch?ftsf?hrung: Klaus Becker, Roland Knapp
Sitz der Gesellschaft: Karlsruhe
Handelsregister: Amtsgericht Mannheim HRB 107658
--------------------------------------------------------------

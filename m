From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 2 Jan 2014 09:42:52 +0100
Subject: About Mail-Followup-To and Mutt [Was: Re: [ARM] Fix kernel
 compile error: drivers/crypto/ixp4xx_crypto.c]
In-Reply-To: <20140101121822.GA20094@book.gsilab.sittig.org>
References: <m3d2kduwd7.fsf@t19.piap.pl>
 <20131231134820.GS8064@book.gsilab.sittig.org>
 <20131231181427.GE16456@n2100.arm.linux.org.uk>
 <20140101121822.GA20094@book.gsilab.sittig.org>
Message-ID: <20140102084252.GF10158@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 01, 2014 at 01:18:22PM +0100, Gerhard Sittig wrote:
> On Tue, Dec 31, 2013 at 18:14 +0000, Russell King - ARM Linux wrote:
> > 
> > Please get rid of your Mail-Followup-To: header:
> > 
> > Mail-Followup-To: Krzysztof Ha?asa <khalasa@piap.pl>,                           
> >         lkml <linux-kernel@vger.kernel.org>,                                    
> >         linux-arm-kernel at lists.infradead.org,                                   
> >         Russell King <rmk+kernel@arm.linux.org.uk>,                             
> >         Christian Hohnstaedt <chohnstaedt@innominate.com>,                      
> >         Herbert Xu <herbert@gondor.apana.org.au>                                
> > User-Agent: Mutt/1.5.21 (2010-09-15)                                            
> > 
> > It causes all recipients following the thread to be moved into the To:
> > header when someone replies to one of your messages, which is deemed to
> > be anti-social.  You can kill this header by adding:
> > 
> > 	set followup_to=no
> > 
> > to your .muttrc file.
> 
> Thank you for telling me, I was not aware.  Had no MFT related
> setting in my config, learned from the manual that $followup_to
> defaults to yes, have turned it off now.  Other mutt users may
> want to check as well.  Happy new year! :)
I have

	# set followup_to = yes

in my .mutt/muttrc---so I'm using the default---but I'm still
unaffected. I think this is because I don't have any lists specified
(using the lists and subscribe commands). And note that there are lists
that consider using MFT to be good, ISTR that it applies to
*@lists.debian.org, but cannot currently find a reference to support
that claim. The problem is that using MFT only works if all recipents
are using and respecting it.

If Russell is annoyed in general by MFT, he could unset
honor_followup_to.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

From: gsi@denx.de (Gerhard Sittig)
Date: Wed, 1 Jan 2014 13:18:22 +0100
Subject: [ARM] Fix kernel compile error: drivers/crypto/ixp4xx_crypto.c.
In-Reply-To: <20131231181427.GE16456@n2100.arm.linux.org.uk>
References: <m3d2kduwd7.fsf@t19.piap.pl>
 <20131231134820.GS8064@book.gsilab.sittig.org>
 <20131231181427.GE16456@n2100.arm.linux.org.uk>
Message-ID: <20140101121822.GA20094@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 31, 2013 at 18:14 +0000, Russell King - ARM Linux wrote:
> 
> Please get rid of your Mail-Followup-To: header:
> 
> Mail-Followup-To: Krzysztof Ha?asa <khalasa@piap.pl>,                           
>         lkml <linux-kernel@vger.kernel.org>,                                    
>         linux-arm-kernel at lists.infradead.org,                                   
>         Russell King <rmk+kernel@arm.linux.org.uk>,                             
>         Christian Hohnstaedt <chohnstaedt@innominate.com>,                      
>         Herbert Xu <herbert@gondor.apana.org.au>                                
> User-Agent: Mutt/1.5.21 (2010-09-15)                                            
> 
> It causes all recipients following the thread to be moved into the To:
> header when someone replies to one of your messages, which is deemed to
> be anti-social.  You can kill this header by adding:
> 
> 	set followup_to=no
> 
> to your .muttrc file.

Thank you for telling me, I was not aware.  Had no MFT related
setting in my config, learned from the manual that $followup_to
defaults to yes, have turned it off now.  Other mutt users may
want to check as well.  Happy new year! :)


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de

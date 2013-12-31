From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 31 Dec 2013 18:14:27 +0000
Subject: [ARM] Fix kernel compile error: drivers/crypto/ixp4xx_crypto.c.
In-Reply-To: <20131231134820.GS8064@book.gsilab.sittig.org>
References: <m3d2kduwd7.fsf@t19.piap.pl>
 <20131231134820.GS8064@book.gsilab.sittig.org>
Message-ID: <20131231181427.GE16456@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please get rid of your Mail-Followup-To: header:

Mail-Followup-To: Krzysztof Ha?asa <khalasa@piap.pl>,                           
        lkml <linux-kernel@vger.kernel.org>,                                    
        linux-arm-kernel at lists.infradead.org,                                   
        Russell King <rmk+kernel@arm.linux.org.uk>,                             
        Christian Hohnstaedt <chohnstaedt@innominate.com>,                      
        Herbert Xu <herbert@gondor.apana.org.au>                                
User-Agent: Mutt/1.5.21 (2010-09-15)                                            

It causes all recipients following the thread to be moved into the To:
header when someone replies to one of your messages, which is deemed to
be anti-social.  You can kill this header by adding:

	set followup_to=no

to your .muttrc file.

Thanks.

From: joe@perches.com (Joe Perches)
Date: Sun, 20 Nov 2011 12:59:02 -0800
Subject: [PATCH] ARM: sa1100: refactor sa1100 serial driver
In-Reply-To: <1321822068.17619.3.camel@Joe-Laptop>
References: <1321821127-32231-1-git-send-email-jochen@scram.de>
 <1321822068.17619.3.camel@Joe-Laptop>
Message-ID: <1321822742.17619.6.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-11-20 at 12:47 -0800, Joe Perches wrote:
> On Sun, 2011-11-20 at 21:32 +0100, Jochen Friedrich wrote:
> > - move pin initialization into board files
> > - make use of resources in platform device
> >   rather than hardcoding them in the driver
> > - add DT support
> 
> trivia:

I get these bounce messages a lot.
Any clue how to resolve them?

Failed to deliver to 'jochen at scram.de'
SMTP module(domain @206.117.179.246:scram.de) reports:
 return-path address <joe@perches.com> rejected by mail1.scram.de:
 ?c?s?1
0       U
TR10U
ANKARA1V0TU

Failed to deliver to 'devicetree-discuss at lists.ozlabs.org'
SMTP module(domain @206.117.179.246:lists.ozlabs.org) reports:
 return-path address <joe@perches.com> rejected by mx.ozlabs.org:
 aat der Nederlanden1+0)U
"Staat der Nederlanden Root CA - G2

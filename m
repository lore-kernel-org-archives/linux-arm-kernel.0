From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 9 Apr 2012 15:01:40 +0000
Subject: [PATCH V3 1/5] ARM: kirkwood: Basic support for DNS-320 and
 DNS-325
In-Reply-To: <alpine.DEB.2.00.1204091513250.23719@marmot.wormnet.eu>
References: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
 <201204091409.04927.arnd@arndb.de>
 <alpine.DEB.2.00.1204091513250.23719@marmot.wormnet.eu>
Message-ID: <201204091501.40176.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 April 2012, Jamie Lentin wrote:
> Add support for the DNS-320 and DNS-325. Describe as much as currently 
> possible in the devicetree files, create a board-dnskw.c for everything 
> else.
> 
> Changes since last submission (V2):-
> 
> * Use IEEE-compliant "okay", rather than "ok" (adressing comments from 
> Scott Wood)
> 

Looks great, yes.

	Arnd

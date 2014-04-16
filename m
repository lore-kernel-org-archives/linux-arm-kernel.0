From: w@1wt.eu (Willy Tarreau)
Date: Wed, 16 Apr 2014 11:45:52 +0200
Subject: [PATCH 0/3] net: mvneta: fix usage as a module,
 and support QSGMII properly
In-Reply-To: <1397569821-5530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397569821-5530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140416094551.GA1524@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Tue, Apr 15, 2014 at 03:50:18PM +0200, Thomas Petazzoni wrote:
(...)
> This set of patches has been tested on:
> 
>  * Armada XP GP (four QSGMII interfaces)
>  * Armada XP DB (two RGMII interfaces and two SGMII interfaces)
>  * Armada 370 Mirabox (two RGMII interfaces)
> 
> I've tested both the driver built-in, and compiled as a module.
> 
> Since the last attempt at fixing this was quite a fiasco, I'd like
> this new attempt to be tested more widely before being applied. I'll
> try to do some testing on other Armada boards I have, but independent
> testing from other persons would also be appreciated.
> 
> Note that these patches apply after reverting the previous attempt,
> obviously.

Just tried on the AX3 using 3.14 with the last fix reverted, and it
works fine here as well both built-in and as a module. Feel free to
add my :

  Tested-by: Willy Tarreau <w@1wt.eu>

Great work!
Willy

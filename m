From: marex@denx.de (Marek Vasut)
Date: Sun, 22 Jun 2014 14:25:36 +0200
Subject: [PATCH v3 2/4] crypto: Update makefile and Kconfig for Security
 System
In-Reply-To: <53A6C4EE.2020400@gmail.com>
References: <1402404197-4236-1-git-send-email-clabbe.montjoie@gmail.com>
 <201406142101.30546.marex@denx.de> <53A6C4EE.2020400@gmail.com>
Message-ID: <201406221425.36171.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, June 22, 2014 at 01:58:38 PM, Corentin LABBE wrote:
> Le 14/06/2014 21:01, Marek Vasut a ?crit :
> > On Tuesday, June 10, 2014 at 02:43:15 PM, LABBE Corentin wrote:
> >> Add necessary changes for configuring and compiling the Security System
> >> driver.
> >> 
> >> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> >> ---
> >> 
> >>  drivers/crypto/Kconfig  | 91
> >> 
> >> +++++++++++++++++++++++++++++++++++++++++++++++++
> >> drivers/crypto/Makefile
> >> 
> >> |  1 +
> >>  
> >>  2 files changed, 92 insertions(+)
> > 
> > This should be part of 1/4, otherwise 1/4 just adds dead code.
> 
> If I do that 1/4 add to the makefile a path that do not exists.
> 
> But as you like I will change that.

Well, the point is to add stuff which is logically coupled together (code, 
Makefile entry, Kconfig entry) in a single patch if possible.

Best regards,
Marek Vasut

From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Apr 2012 15:02:51 +0000
Subject: [PATCH] ARM: optimize for FA526 if toolchain supports it
In-Reply-To: <4F9561E4.2030100@openwrt.org>
References: <1335184313-27573-1-git-send-email-florian@openwrt.org>
 <201204231315.20648.arnd@arndb.de> <4F9561E4.2030100@openwrt.org>
Message-ID: <201204231502.51563.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 April 2012, Florian Fainelli wrote:
> Le 04/23/12 15:15, Arnd Bergmann a ?crit :
> > On Monday 23 April 2012, Florian Fainelli wrote:
> >> Currently, when we are targetting a Farady FA526-based system
> >> the toolchain will use the arm9tdmi mtune option of gcc, gcc>  4.6
> >> supports the FA526 CPU, and allow us to optimize for it.
> >>
> >> Signed-off-by: Florian Fainelli<florian@openwrt.org>
> > No objections to the patch, but a question out of curiosity:
> >
> > Is this the regular gemini platform that you are working on,
> > or something else? Do you have other platform support patches
> > that you are planning to submit for this?
> 
> I need this on a different platform (Moschip MCS814x), which I will be 
> submitting once I have all the bits working and converted to device tree.

Ok, good to know. 

Thanks,

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 1 Apr 2011 13:32:35 +0200
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <alpine.LFD.2.00.1103311826070.22418@localhost6.localdomain6>
References: <201103301906.42429.arnd@arndb.de>
	<201103311723.02301.arnd@arndb.de>
	<alpine.LFD.2.00.1103311826070.22418@localhost6.localdomain6>
Message-ID: <201104011332.35618.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 March 2011, Thomas Gleixner wrote:
> On Thu, 31 Mar 2011, Arnd Bergmann wrote:
>
> Right, but the problem starts in way simpler areas like irq chips and
> gpio stuff, where lots of the IP cores are similar and trivial enough
> to be shared across many SoC families.

Yes, I'm sure that there are more obvious examples than the ones I've
given, those were just the ones that I had noticed myself.
 
> Even the OMAP "consolidated" code is silly:
>
> But the code above has 6 cases in the switch because nobody abstracted
> it out consequently. Not to talk about the ifdef mess.

Nice illustration.

	Arnd

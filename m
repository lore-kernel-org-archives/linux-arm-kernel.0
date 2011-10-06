From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 6 Oct 2011 13:46:02 -0600 (MDT)
Subject: [PATCH] ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock
	control detection
In-Reply-To: <CAGDS+nno3=sDDwdF6Ew6qG-8mN9bCeawCpho+AJo=jE9QVk0ag@mail.gmail.com>
References: <alpine.DEB.2.00.1110061310390.4611@utopia.booyaka.com>
	<CAGDS+nno3=sDDwdF6Ew6qG-8mN9bCeawCpho+AJo=jE9QVk0ag@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1110061345260.4611@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Oct 2011, Steve Sakoman wrote:

> Perhaps I'm confused but shouldn't it be an || instead of &&?
> 
> We're testing for ES3.1 *or* ES3.12?

You're correct - thanks for catching this.  v2 on its way.

- Paul

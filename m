From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 10 Jun 2011 22:52:47 -0400 (EDT)
Subject: [PATCH v2] ARM: kirkwood: Add support for Buffalo LS-XHL
In-Reply-To: <20110610134508.GL8223@kw.sim.vm.gnt>
References: <1307655488-12811-1-git-send-email-michael@walle.cc>
	<1307655488-12811-2-git-send-email-michael@walle.cc>
	<20110610134508.GL8223@kw.sim.vm.gnt>
Message-ID: <alpine.LFD.2.00.1106102233370.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 10 Jun 2011, Simon Guinot wrote:

> BTW, I don't know if Nicolas will mainline this old fashioned board
> setup. He is waiting for a DT alternative for Kirkwood.

That's exact.  Right now there is a de facto moratorium with the 
addition of old style board support to the mainline kernel.

We need some generic Kirkwood infrastructure based on device tree to be 
created instead.  And then the addition of support for a new board would 
only require a new DTB to be passed to the kernel.


Nicolas

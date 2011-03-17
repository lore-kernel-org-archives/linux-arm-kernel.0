From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Thu, 17 Mar 2011 23:49:22 +0100
Subject: [PATCH 7/9] lpc2k: Add EmbeddedArtists LPC2478 Developer's Kit
	board
In-Reply-To: <083DF309106F364B939360100EC290F80B15AC2B40@eu1rdcrdc1wx030.exi.nxp.com>
References: <1300377264-10843-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300377264-10843-8-git-send-email-ithamar.adema@team-embedded.nl>
	<083DF309106F364B939360100EC290F80B15AC2B40@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <1300402162.2138.112.camel@team-embedded-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-03-17 at 23:33 +0100, Kevin Wells wrote:
> > +     lpc2k_init_clocks(12000000UL, 32768000UL);
> 
> Should the RTC clock be 32768? 

Yes, it should be. Will fix.

Ithamar.

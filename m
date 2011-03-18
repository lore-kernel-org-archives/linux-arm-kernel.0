From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Fri, 18 Mar 2011 19:32:24 +0100
Subject: [PATCH v2 4/9] lpc2k: generic time and clockevents
In-Reply-To: <083DF309106F364B939360100EC290F80B15C9BD57@eu1rdcrdc1wx030.exi.nxp.com>
References: <1300461116-6028-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300461116-6028-5-git-send-email-ithamar.adema@team-embedded.nl>
	<20110318152012.GM29758@n2100.arm.linux.org.uk>
	<083DF309106F364B939360100EC290F80B15C9BD57@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <1300473144.2138.166.camel@team-embedded-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-03-18 at 18:15 +0100, Kevin Wells wrote:
> I didn't see a specific enable for timer0, it seems to work for me
> because my boot loader leaves it on when booting the kernel, but
> maybe it's also needed. 

Will add, it works because TIMER0 and TIMER1 are both enabled on RESET,
and the bootloader does indeed not disable them.

Regards,

Ithamar.

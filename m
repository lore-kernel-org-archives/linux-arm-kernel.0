From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 31 Oct 2011 18:43:18 -0400 (EDT)
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <20111029135653.GA25057@mudshark.cambridge.arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
	<20111029102108.GY19187@n2100.arm.linux.org.uk>
	<20111029135653.GA25057@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1110311839330.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 29 Oct 2011, Will Deacon wrote:

> I'll give this a go for v2, thanks. Once this is sorted out I'll do a second
> pass to clean up the reboot modes since I've already got some patches for
> that.

OK great.  Please ask Russell to merge your series whenever you're ready 
after 3.2-rc1 and I'll rebase my arch_idle series on top of that.


Nicolas

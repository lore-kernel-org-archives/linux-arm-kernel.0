From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Feb 2010 23:55:18 +0000
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <20100225234845.GH24043@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1002241824520.1946@xanadu.home>
	<20100224234215.GA21985@n2100.arm.linux.org.uk>
	<4B85BCE0.7000903@marcansoft.com>
	<20100225000114.GB21985@n2100.arm.linux.org.uk>
	<4B85C4A4.4060005@marcansoft.com>
	<alpine.LFD.2.00.1002242309030.1946@xanadu.home>
	<20100225093859.GA19870@n2100.arm.linux.org.uk>
	<20100225122429.GA3101@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002251420160.1946@xanadu.home>
	<20100225234845.GH24043@n2100.arm.linux.org.uk>
Message-ID: <20100225235518.GI24043@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2010 at 11:48:45PM +0000, Russell King - ARM Linux wrote:
> -		.word	_got_start		@ r6
> +		.word	_end			@ r6

Grr, that should be _etext.

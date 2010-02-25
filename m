From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 24 Feb 2010 23:33:36 -0500 (EST)
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <alpine.LFD.2.00.1002242309030.1946@xanadu.home>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
	<20100224223418.GB25587@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002241824520.1946@xanadu.home>
	<20100224234215.GA21985@n2100.arm.linux.org.uk>
	<4B85BCE0.7000903@marcansoft.com>
	<20100225000114.GB21985@n2100.arm.linux.org.uk>
	<4B85C4A4.4060005@marcansoft.com>
	<alpine.LFD.2.00.1002242309030.1946@xanadu.home>
Message-ID: <alpine.LFD.2.00.1002242332160.1946@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Feb 2010, Nicolas Pitre wrote:

> Put this in a common header file for the decompressor code:
> 
> /* ARM wants to redefine this sometimes */
> #ifndef static_func
> #define static_func
> #endif

Obviously I meant

#define static_func static


Nicolas

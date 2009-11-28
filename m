From: nico@fluxnic.net (Nicolas Pitre)
Date: Sat, 28 Nov 2009 11:41:39 -0500 (EST)
Subject: [PATCH 1/3] ARM: add base support for Marvell Dove SoC
In-Reply-To: <c70ff3ad0911280004y5a78bed2ndc134c2a7e8b4382@mail.gmail.com>
References: <1259084033-7283-1-git-send-email-saeed@marvell.com>
	<1259084033-7283-2-git-send-email-saeed@marvell.com>
	<FCBE654890C0334289D0AD3AF4EF009F89684D7F09@IL-MB01.marvell.com>
	<20091127200521.GC28193@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0911271547110.2059@xanadu.home>
	<c70ff3ad0911280004y5a78bed2ndc134c2a7e8b4382@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.0911281140080.5388@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 28 Nov 2009, saeed bishara wrote:

> The board id that supported by this patch is 1788, the board name in
> the machines registry updated to dove_db, but the Type Identifier
> needs to be changed from MACH_TYPE_MACH_MARVELL_NEW1 to
> MACH_TYPE_DOVE_DB.

The orion repo has the right machine identifier already. No changes 
needed there.


Nicolas

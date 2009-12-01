From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Dec 2009 09:57:28 +0000
Subject: [PATCH 1/3] ARM: add base support for Marvell Dove SoC
In-Reply-To: <c70ff3ad0911280004y5a78bed2ndc134c2a7e8b4382@mail.gmail.com>
References: <1259084033-7283-1-git-send-email-saeed@marvell.com>
	<1259084033-7283-2-git-send-email-saeed@marvell.com>
	<FCBE654890C0334289D0AD3AF4EF009F89684D7F09@IL-MB01.marvell.com>
	<20091127200521.GC28193@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.0911271547110.2059@xanadu.home>
	<c70ff3ad0911280004y5a78bed2ndc134c2a7e8b4382@mail.gmail.com>
Message-ID: <20091201095728.GB29135@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 28, 2009 at 10:04:06AM +0200, saeed bishara wrote:
> The board id that supported by this patch is 1788, the board name in
> the machines registry updated to dove_db, but the Type Identifier
> needs to be changed from MACH_TYPE_MACH_MARVELL_NEW1 to
> MACH_TYPE_DOVE_DB.

Unable to do so.  There's another platform using MACH_TYPE_DOVE_DB.

Please chose a different name for your platform.

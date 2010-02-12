From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Feb 2010 14:31:36 +0000
Subject: [PATCH 12/14] AMBA: CLCD: LPC32XX register swap in the clcd
	header file
In-Reply-To: <1265674295-23996-13-git-send-email-wellsk40@gmail.com>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
	<1265674295-23996-13-git-send-email-wellsk40@gmail.com>
Message-ID: <20100212143136.GA18595@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2010 at 04:11:33PM -0800, wellsk40 at gmail.com wrote:
> The CTRL and IENB registers need to be swapped for the LPC32XX
> arch.

Is your peripheral a PL110 or PL111 ?

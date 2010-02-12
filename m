From: kevin.wells@nxp.com (Kevin Wells)
Date: Fri, 12 Feb 2010 17:32:58 +0100
Subject: [PATCH 12/14] AMBA: CLCD: LPC32XX register swap in the clcd
	header file
In-Reply-To: <20100212143136.GA18595@n2100.arm.linux.org.uk>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
	<1265674295-23996-13-git-send-email-wellsk40@gmail.com>
	<20100212143136.GA18595@n2100.arm.linux.org.uk>
Message-ID: <083DF309106F364B939360100EC290F805C8D3D7DD@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> On Mon, Feb 08, 2010 at 04:11:33PM -0800, wellsk40 at gmail.com wrote:
> > The CTRL and IENB registers need to be swapped for the LPC32XX
> > arch.
> 
> Is your peripheral a PL110 or PL111 ?
> 

This part uses an unmodified PL111.

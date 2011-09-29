From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Sep 2011 11:49:54 +0100
Subject: [PATCHv2 2/2] ARM: debug: Move DEBUG_ICEDCC into the DEBUG_LL
	choice
In-Reply-To: <20110929103939.GD25061@e102144-lin.cambridge.arm.com>
References: <1316568208-4518-1-git-send-email-sboyd@codeaurora.org>
	<1316568208-4518-2-git-send-email-sboyd@codeaurora.org>
	<4E83D25C.6020306@codeaurora.org>
	<20110929092102.GB25061@e102144-lin.cambridge.arm.com>
	<20110929094243.GC25061@e102144-lin.cambridge.arm.com>
	<20110929094602.GH23944@n2100.arm.linux.org.uk>
	<20110929103939.GD25061@e102144-lin.cambridge.arm.com>
Message-ID: <20110929104954.GI23944@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 29, 2011 at 11:39:39AM +0100, Will Deacon wrote:
> Ok. Rather than 'default' (which people will probably select in preference
> to choosing the correct UART) how about something like below? I can split
> this into two patches if you prefer.

Yup, that's what I meant.

From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jan 2010 23:11:43 +0000
Subject: [RFC 18/18] arm: mm: qsd8x50: Fix incorrect permission faults
In-Reply-To: <1263250057-26692-19-git-send-email-dwalker@codeaurora.org>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-19-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100111231143.GF7925@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 02:47:37PM -0800, Daniel Walker wrote:
> From: Dave Estes <cestes@quicinc.com>
> 
> Handle incorrectly reported permission faults for qsd8650.  On
> permission faults, retry MVA to PA conversion.  If retry detects
> translation fault.  Report as translation fault.

This is totally unacceptable to add such a demanding copyright header to
any file, imposing this notice upon pre-existing code.  Please remove it.

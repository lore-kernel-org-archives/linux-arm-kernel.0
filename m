From: benjamin.zores@alcatel-lucent.com (Benjamin Zores)
Date: Mon, 21 Jun 2010 14:08:55 +0200
Subject: [PATCH 1/4] arch/arm/mach-kirkwood: update MPP definition.
In-Reply-To: <20100617075858.15387.93749.stgit@localhost.localdomain>
References: <20100617075711.15387.69398.stgit@localhost.localdomain>
	<20100617075858.15387.93749.stgit@localhost.localdomain>
Message-ID: <4C1F5657.9000800@alcatel-lucent.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/2010 09:58, Benjamin Zores wrote:
> Add MPP definitions for Marvell Kirkwood 88F6282 revision.
> Update some defines to reflect datasheet's MPP names.
>    

Marvell published an errata note regarding 6282 MPPs.
Attached is a slightly modified patch (for MPP49, others were ok).

Nicolas, Catalin, can you merge the 4 patches to your tree ?

Ben
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: mv88f6282-mpp.diff
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100621/7d29f44e/attachment-0001.ksh>

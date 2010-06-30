From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 30 Jun 2010 13:03:31 -0700
Subject: [PATCH 04/33] Removing dead MSM7X00A_IDLE
In-Reply-To: <20100630195933.GD3969@shutemov.name>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<c7e75d44aebaaabfdff9cf5fbda54512d0062728.1277911346.git.siccegge@cs.fau.de>
	<20100630195933.GD3969@shutemov.name>
Message-ID: <1277928211.30401.39.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-06-30 at 22:59 +0300, Kirill A. Shutemov wrote:
> On Wed, Jun 30, 2010 at 05:55:03PM +0200, Christoph Egger wrote:
> > MSM7X00A_IDLE doesn't exist in Kconfig, therefore removing all
> > references for it from the source code.
> 
> It was removed in commit 1637de0c9. I'm not sure if it's correct.
> 
> Brian Swetland added to CC list.

Yeah, it looks like it was missed in the original commit.

Daniel

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

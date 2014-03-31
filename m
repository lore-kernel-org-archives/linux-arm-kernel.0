From: tim.zhang@spreadtrum.com (Yang Zhang)
Date: Mon, 31 Mar 2014 04:11:26 +0000 (UTC)
Subject: [PATCH 0/5] arm: Early IRQ enabling in the Undef user handler
References: <1377689664-27614-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <loom.20140331T053123-366@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas <at> arm.com> writes:

> (an alternative simpler patch would be to enable the interrupts only
> around the user access instructions in __und_usr and disable them
> afterwards, so I would rather do it as in this series).

Tested-by: Yang Zhang<email:tim.zhang@spreadtrum.com>

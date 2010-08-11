From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Wed, 11 Aug 2010 08:43:05 +0300 (EEST)
Subject: [PATCHv2] mailbox: change full flag per mailbox queue instead
	of global
In-Reply-To: <1281489169-15945-1-git-send-email-x0095840@ti.com>
References: <1281489169-15945-1-git-send-email-x0095840@ti.com>
Message-ID: <20100811.084305.149819136.Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: ext Fernando Guzman Lugo <x0095840@ti.com>
Subject: [PATCHv2] mailbox: change full flag per mailbox queue instead of global
Date: Wed, 11 Aug 2010 03:12:49 +0200

> As pointed by Ohad Ben-Cohen, the variable rq_full flag is a
> global variable, so if there are multiple mailbox users
> there will be conflics. Now there is a full flag per
> mailbox queue.
> 
> Version 2:
> - Rebase to the latest.
> 
> Reported-by: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Ok for me.
Tony, could you take this in? since it's a single patch for fix.

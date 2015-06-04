From: balbi@ti.com (Felipe Balbi)
Date: Thu, 4 Jun 2015 15:08:50 -0500
Subject: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
In-Reply-To: <55701E93.60303@free.fr>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <2466648.WjMxjIpAUG@wuerfel>
 <20150603210455.GD6042@saruman.tx.rr.com>
 <20150603212821.GH6042@saruman.tx.rr.com>
 <556F7493.2060602@codeaurora.org>
 <20150603215445.GK6042@saruman.tx.rr.com> <55701E93.60303@free.fr>
Message-ID: <20150604200850.GF5710@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 04, 2015 at 11:46:59AM +0200, Mason wrote:
> Also, check /proc/timer_list for a "Broadcast device". If you don't
> define one, the TWD timers are set to periodic mode, with hrtimers
> disabled.

Did you manage to turn global timer into Broadcast device ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150604/4feb0436/attachment.sig>

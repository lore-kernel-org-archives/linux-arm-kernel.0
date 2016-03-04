From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 4 Mar 2016 14:34:29 -0800
Subject: [PATCHv2 0/3] KASAN: clean stale poison upon cold re-entry to
 kernel
In-Reply-To: <1457024068-2236-1-git-send-email-mark.rutland@arm.com>
References: <1457024068-2236-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160304143429.22d7a6fa522956535ba6000e@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  3 Mar 2016 16:54:25 +0000 Mark Rutland <mark.rutland@arm.com> wrote:

> Andrew, the conclusion [5] from v1 was that this should go via the mm tree.
> Are you happy to pick this up? 

yep.  I'll aim to get this into 4.5.

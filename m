From: horms@verge.net.au (Simon Horman)
Date: Fri, 2 Oct 2015 10:57:13 +0900
Subject: [PATCH 13/38] ARM: shmobile: apmu: correct type of CPU id
In-Reply-To: <1442842450-29769-14-git-send-email-a.hajda@samsung.com>
References: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
 <1442842450-29769-14-git-send-email-a.hajda@samsung.com>
Message-ID: <20151002015713.GA7043@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 21, 2015 at 03:33:45PM +0200, Andrzej Hajda wrote:
> CPU id can be negative, so it cannot be assigned to unsigned variable.
> 
> The problem has been detected using proposed semantic patch
> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].
> 
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2038576
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>

Thanks, I have queued this up as a cleanup for v4.4.

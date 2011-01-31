From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 31 Jan 2011 11:58:19 +0100
Subject: [PATCH] ARM:ucb1x00-ts: Fix NULL pointer due to
	non-initialized absinfo
In-Reply-To: <1296037801-20427-1-git-send-email-jochen@scram.de>
References: <1296037801-20427-1-git-send-email-jochen@scram.de>
Message-ID: <20110131105818.GF5954@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jochen,

On Wed, Jan 26, 2011 at 11:30:01AM +0100, Jochen Friedrich wrote:
> Call input_set_abs_params instead of manually setting absbit only.
> This fixes this oops:
Thanks for the fix, I applied the patch to both my for-next and for-linus
branches.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

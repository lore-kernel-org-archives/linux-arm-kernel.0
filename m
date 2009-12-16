From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 16 Dec 2009 11:23:31 -0700
Subject: [PATCH] dma: at_hdmac: correct incompatible type for argument 1
	of 'spin_lock_bh'
In-Reply-To: <1260980883-30030-1-git-send-email-nicolas.ferre@atmel.com>
References: <1260980883-30030-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <e9c3a7c20912161023ta19f0b3qe32899e27d0875d1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 16, 2009 at 9:28 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Correct a typo error in locking calls.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Applied, and added stable at kernel.org to the cc.

--
Dan

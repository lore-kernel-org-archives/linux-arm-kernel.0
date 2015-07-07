From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 7 Jul 2015 09:52:53 +0530
Subject: [PATCH 1/1] dmaengine: Use Pointer xt after NULL check.
In-Reply-To: <1435314888-20491-1-git-send-email-maninder1.s@samsung.com>
References: <1435314888-20491-1-git-send-email-maninder1.s@samsung.com>
Message-ID: <20150707042253.GI11002@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 26, 2015 at 04:04:48PM +0530, Maninder Singh wrote:
> Removing static analysis error:-
> Possible null pointer dereference: xt
> 
> Because currently xt is dereferenced before NULL check,
> Thus Use it after NULL Check.
> 
Applied, thanks

-- 
~Vinod

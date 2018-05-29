From: horms@verge.net.au (Simon Horman)
Date: Tue, 29 May 2018 17:13:45 +0100
Subject: [PATCH v2 3/5] crypto: ccree: silence debug prints
In-Reply-To: <1527171551-21979-4-git-send-email-gilad@benyossef.com>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
 <1527171551-21979-4-git-send-email-gilad@benyossef.com>
Message-ID: <20180529161345.rhx73mixbnxrfzum@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 03:19:08PM +0100, Gilad Ben-Yossef wrote:
> The cache parameter register configuration was being too verbose.
> Use dev_dbg() to only provide the information if needed.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 25 Feb 2014 20:18:47 +0800
Subject: [PATCH] crypto: tegra: remove driver
In-Reply-To: <1392759778-13904-1-git-send-email-swarren@wwwdotorg.org>
References: <1392759778-13904-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140225121846.GH12216@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 02:42:57PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> This driver has never been hooked up in any board file, and cannot be
> instantiated via device tree. I've been told that, at least on Tegra20,
> the HW is slower at crypto than the main CPU. I have no test-case for
> it. Hence, remove it.
> 
> Cc: Varun Wadekar <vwadekar@nvidia.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Patch applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

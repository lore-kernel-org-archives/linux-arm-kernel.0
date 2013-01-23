From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 23 Jan 2013 10:54:11 +0000
Subject: [PATCH 7/7] clk: vexpress: Use common of_clk_init() function
In-Reply-To: <1357282858-2112-7-git-send-email-pgaikwad@nvidia.com>
References: <1357282858-2112-1-git-send-email-pgaikwad@nvidia.com>
 <1357282858-2112-7-git-send-email-pgaikwad@nvidia.com>
Message-ID: <1358938451.26878.1.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-01-04 at 07:00 +0000, Prashant Gaikwad wrote:
> Use common of_clk_init() function for clock initialization.
> 
> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>

Just tested on VE, looks good to me.

So for this patch and the "[1/7] clk: add common of_clk_init() function"
one:

Tested-by: Pawel Moll <pawel.moll@arm.com>

Cheers!

Pawel

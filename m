From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 11 Jul 2018 20:47:55 +0800
Subject: [PATCH] ARM: imx: flag failure of of_iomap
In-Reply-To: <1531038774-24657-1-git-send-email-hofrat@osadl.org>
References: <1531038774-24657-1-git-send-email-hofrat@osadl.org>
Message-ID: <20180711124754.GG6959@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 08, 2018 at 10:32:54AM +0200, Nicholas Mc Guire wrote:
>  imx_set_aips is assuming that the address returned from of_iomap is
> valid which it probably is in the normal case - as the call site
> is void error propagation is not possible but never the less at least
> a WARN_ON() seems warranted here.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit e57e4ab5fc2e ("ARM: i.MX: allow disabling supervisor protect via DT")

Applied, thanks.

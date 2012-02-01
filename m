From: olof@lixom.net (Olof Johansson)
Date: Tue, 31 Jan 2012 23:26:59 -0800
Subject: [PATCH v2 1/8] ARM: tegra: export the chipid
In-Reply-To: <1328028051-24271-2-git-send-email-pdeschrijver@nvidia.com>
References: <1328028051-24271-1-git-send-email-pdeschrijver@nvidia.com>
 <1328028051-24271-2-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20120201072659.GD7399@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2012 at 06:40:39PM +0200, Peter De Schrijver wrote:
> Export a variable containing the Tegra chipid. This will be used by the SMP
> code to distinguish between Tegra variants. Also initialize the Tegra chipid
> on Tegra30.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Ideally this patch should be split up in a couple of separate ones, first
cleanup, then the new functionality. But it's not a big deal, and I'll apply it
as it is now. Just something to keep in mind for the next time around.


-Olof

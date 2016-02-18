From: tj@kernel.org (Tejun Heo)
Date: Thu, 18 Feb 2016 12:41:56 -0500
Subject: [PATCH v4 04/12] ata: ahci_mvebu: add support for Armada 3700
 variant
In-Reply-To: <1455646502-23834-5-git-send-email-gregory.clement@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
 <1455646502-23834-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160218174156.GF13177@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 07:14:54PM +0100, Gregory CLEMENT wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> The main difference in the new Armada 3700 is that no address
> decoding needs to take place in the driver probe.
> 
> [gregory.clement at free-electrons.com: reformulate the commit log]
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Reviewed-by: Nadav Haklai <nadavh@marvell.com>
> Tested-by: Nadav Haklai <nadavh@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied to libata/for-4.6.

Thanks.

-- 
tejun

From: tj@kernel.org (Tejun Heo)
Date: Wed, 15 Jan 2014 07:44:40 -0500
Subject: [PATCH v3 0/3] Fix SATA disk hotplug for Armada 370/XP SoCs
In-Reply-To: <1389726281-8731-1-git-send-email-simon.guinot@sequanux.org>
References: <1389726281-8731-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20140115124440.GA7950@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 08:04:38PM +0100, Simon Guinot wrote:
> Hello,
> 
> This patch series fixes a SATA disk hotplug issue for the Armada 370/XP
> SoCs: once a disk is removed from a SATA port, then the re-plug events
> are not detected by the sata_mv driver.
> 
> As this hotplug issue have been emphasized by 9ae6f740b49f
> "arm: mach-mvebu: add support for Armada 370 and Armada XP with DT",
> then this patches should be applied to the -stable kernels 3.6 and
> onwards.

Applied to libata/for-3.14.

Thanks.

-- 
tejun

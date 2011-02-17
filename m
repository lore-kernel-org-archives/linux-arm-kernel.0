From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Thu, 17 Feb 2011 16:12:07 +0530
Subject: [PATCH 0/8] OMAP4: hwmod data: Add a bunch of IPs
In-Reply-To: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
References: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
Message-ID: <20110217104207.GB17370@m-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17, 2011 at 11:24:41AM +0100, Benoit Cousson wrote:
> All, 
> 
> Due to the important number of modifications recently done on the
> OMAP4 data compared to the original and the total absence of explanation
> in the changelog, I re-submit the data before the driver series in order
> to maintain the integrity of the original file and to avoid a huge pain
> during the merge.
> 
> Govind, Tarun and Kishon, 
> Please note that I cannot include here the dev_attr or rev field for
> McSPI, McBSP and timer since it requires some modification in the device
> header.

McSPI is already merged to l-o master. Will not this series breaks spi
hwmod?

-Manjunath

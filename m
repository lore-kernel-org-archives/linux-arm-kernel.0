From: tj@kernel.org (Tejun Heo)
Date: Thu, 21 May 2015 18:01:38 -0400
Subject: [PATCH v3 0/5] AHCI and SATA PHY support for Broadcom STB SoCs
In-Reply-To: <20150521220050.GF4914@htj.duckdns.org>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
 <555DDC2B.1040608@ti.com> <20150521220050.GF4914@htj.duckdns.org>
Message-ID: <20150521220138.GG4914@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 06:00:50PM -0400, Tejun Heo wrote:
> Hello,
> 
> On Thu, May 21, 2015 at 06:52:51PM +0530, Kishon Vijay Abraham I wrote:
> > I'll pick "[PATCH v3 2/5] Documentation: devicetree: add Broadcom SATA PHY
> > binding" and
> > "[PATCH v4] phy: add Broadcom SATA3 PHY driver for Broadcom STB SoCs"
> > in the linux-phy tree.
> 
> Applying patch 5 to libata/for-4.2.  If more need to go through
> libata, please let me know.

lol not patch 5, the following one.  Sorry.

[PATCH v3 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips

-- 
tejun

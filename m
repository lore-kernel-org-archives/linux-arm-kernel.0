From: tj@kernel.org (Tejun Heo)
Date: Thu, 21 May 2015 18:04:30 -0400
Subject: [PATCH v3 0/5] AHCI and SATA PHY support for Broadcom STB SoCs
In-Reply-To: <20150521220328.GE11598@ld-irv-0074>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
 <555DDC2B.1040608@ti.com> <20150521220050.GF4914@htj.duckdns.org>
 <20150521220138.GG4914@htj.duckdns.org>
 <20150521220328.GE11598@ld-irv-0074>
Message-ID: <20150521220430.GI4914@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 03:03:28PM -0700, Brian Norris wrote:
> > [PATCH v3 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips
> 
> Thanks. Also, this one?
> 
> [PATCH v3 1/5] Documentation: devicetree: add Broadcom SATA binding

devicetree patches usually haven't gone through libata tho.  Is this
an exception?

Thanks.

-- 
tejun

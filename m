From: tj@kernel.org (Tejun Heo)
Date: Thu, 21 May 2015 18:03:18 -0400
Subject: [PATCH v3 3/5] ata: add Broadcom AHCI SATA3 driver for STB chips
In-Reply-To: <1431473303-18873-4-git-send-email-computersforpeace@gmail.com>
References: <1431473303-18873-1-git-send-email-computersforpeace@gmail.com>
 <1431473303-18873-4-git-send-email-computersforpeace@gmail.com>
Message-ID: <20150521220318.GH4914@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 04:28:21PM -0700, Brian Norris wrote:
> Pretty straightforward driver, using the nice library-ization of the
> generic ahci_platform driver.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>

Applied to libata/for-4.2.

Hans, if you see any issues, please let me know.

Thanks.

-- 
tejun

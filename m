From: bill_carson@126.com (rocky)
Date: Fri, 25 Feb 2011 11:35:52 +0800 (CST)
Subject: Question about free_pgd_slow ?
Message-ID: <79b2dce2.4b84.12e5ae30c01.Coremail.bill_carson@126.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,all

free_pgd_slow in arch/arm/mm/pgd.c  free the 4 pages at pgd level,
while could I ask a question about why free the page by pointed by pgd index 0 ?

cannot figure it out, any tips ?

thanks


rocky




       

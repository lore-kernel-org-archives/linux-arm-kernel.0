From: davem@davemloft.net (David Miller)
Date: Sun, 22 Jun 2014 17:15:25 -0700 (PDT)
Subject: [PATCH v2] xilinx: Fix compiler warning
In-Reply-To: <1403436294-21301-1-git-send-email-manuel.schoelling@gmx.de>
References: <53A6BAC5.80206@cogentembedded.com>
 <1403436294-21301-1-git-send-email-manuel.schoelling@gmx.de>
Message-ID: <20140622.171525.1231955995045407676.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manuel Sch?lling <manuel.schoelling@gmx.de>
Date: Sun, 22 Jun 2014 13:24:54 +0200

> The time comparsion functions require arguments of type unsigned long
> instead of (signed) long.
> 
> Signed-off-by: Manuel Sch?lling <manuel.schoelling@gmx.de>

Applied to net-next, thanks.

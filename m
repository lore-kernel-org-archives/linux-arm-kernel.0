From: computersforpeace@gmail.com (Brian Norris)
Date: Tue, 29 Sep 2015 15:21:44 -0700
Subject: [PATCH 0/2] mtd: nand: sunxi: cleanup
In-Reply-To: <1442389597-30698-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1442389597-30698-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150929222144.GA143959@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 09:46:35AM +0200, Boris Brezillon wrote:
> Hello,
> 
> Those two patches aim at cleaning up the sunxi_nand driver by first adding
> some consistency in the macro definitions, and then factorizing the code
> duplicated code found in hw_ecc and hw_syndrome_ecc implementations.
> 
> Best Regards,
> 
> Boris

I believe this series no longer applies cleanly

From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 17 Sep 2014 22:49:40 -0700
Subject: [PATCHv5] mtd: nand: atmel_nand: retrieve NFC clock
In-Reply-To: <1410564239-8411-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1410564239-8411-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140918054940.GC7362@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 13, 2014 at 01:23:59AM +0200, Alexandre Belloni wrote:
> From: Boris BREZILLON <boris.brezillon@free-electrons.com>
> 
> Retrieve the NFC clock to make sure it is enabled. Make that optional to ensure
> compatibility with previous device trees but document it as mandatory so newer
> device trees will include it.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Josh Wu <josh.wu@atmel.com>
> ---
> Changes in v5:
>  - Added a proper commit log

Pushed to l2-mtd.git. Thanks!

Brian

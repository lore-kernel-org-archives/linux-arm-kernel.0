From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Dec 2011 11:37:23 +0000
Subject: [PATCH 0/7] Cragganmore updates for 3.3
In-Reply-To: <047301ccb014$273745b0$75a5d110$%kim@samsung.com>
References: <20111129133006.GA26800@opensource.wolfsonmicro.com>
 <047301ccb014$273745b0$75a5d110$%kim@samsung.com>
Message-ID: <20111201113722.GE2915@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2011 at 07:29:49PM +0900, Kukjin Kim wrote:

> And as a note, I'm thinking about the handling of different
> IRQ_BOARD_NR...but I'm not sure it is really needed or not :)

Yeah, it's annoying.  I believe that converting to sparse IRQs would
avoid the issue.

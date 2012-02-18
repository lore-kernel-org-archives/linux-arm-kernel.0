From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 17 Feb 2012 21:46:39 -0800
Subject: [PATCH] mtd : change the location of the ONFI detected log
In-Reply-To: <1329448957-9756-1-git-send-email-b32955@freescale.com>
References: <1329448957-9756-1-git-send-email-b32955@freescale.com>
Message-ID: <CAN8TOE944-3W5=oXAG2bnqGZygSn6ALznRPDXsHJxnLdVssiXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 7:22 PM, Huang Shijie <b32955@freescale.com> wrote:
> Some strange nand chip(such as Hynix H27UBG8T2A) can pass the `ONFI` signature
> check. So the log can be printed out even it is not an ONFI nand indeed.
>
> Change this log to the end of the function. Print out the log only when we
> really detect an ONFI nand.
>
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Acked-by: Brian Norris <computersforpeace@gmail.com>

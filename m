From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 2 Jul 2012 09:39:49 -0700
Subject: [RFC PATCH v2] MTD: nand: add return value for
 write_page()/write_page_raw() functions in structure of nand_ecc_ctrl.
In-Reply-To: <4FE83A66.9090100@atmel.com>
References: <1339567570-4816-1-git-send-email-josh.wu@atmel.com>
 <4FE13CB2.3000605@atmel.com>
 <CAN8TOE8iDtzw4eTKa6tJ5oBxbaDUxg9nDLaKBhW4D86vGWxGJg@mail.gmail.com>
 <4FE29CB8.3000404@atmel.com>
 <CAN8TOE9ebFAfJHaG2-po0LeLi=wTq9YZ9pNFXhQE0PLt5TQxeg@mail.gmail.com>
 <4FE83A66.9090100@atmel.com>
Message-ID: <CAN8TOE8LNQSeFW2G_xmeSxz-PvqLcW_WtJMjt5bLnwsz2pAA4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 3:16 AM, Josh Wu <josh.wu@atmel.com> wrote:
> According to your advice, I resent a new patch series, which merge this
> patch with PMECC.

Thanks, it looks good.

BTW, this affects Mike Dunn, who was planning on touching the docg4.c
portion. Mike: note that the write_page() functions in docg4.c have
been changed to fix the "error" we were discussing with return codes
(see l2-mtd-2.6.git).

Brian

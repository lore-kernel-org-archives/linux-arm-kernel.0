From: w@1wt.eu (Willy Tarreau)
Date: Thu, 11 Jan 2018 23:28:33 +0100
Subject: [PATCH v3 0/7] Marvell NAND controller rework with ->exec_op()
In-Reply-To: <20180109103637.23798-1-miquel.raynal@free-electrons.com>
References: <20180109103637.23798-1-miquel.raynal@free-electrons.com>
Message-ID: <20180111222833.GA15584@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,

On Tue, Jan 09, 2018 at 11:36:30AM +0100, Miquel Raynal wrote:
> These changes have been tested on:
>    - PXA3xx platform with a CM-X300 board (2kiB page NAND, 1b/512B
>      strength, Hamming ECC engine) [32 bits]
>    - Armada 385 DB AP (4kiB page NAND, 4b/512B, BCH ECC engine) [32 bits]
>    - Armada 398 DB (4kiB page NAND, 8b/512B, BCH ECC engine using a layout
>      with a last chunk different than the others) [32 bits]
>    - Armada 7040 DB and Armada 8040 DB (4kiB page NAND, 4b/512B, BCH ECC
>      engine) [64 bits]
>    - Triax dvb-tc board (2kiB page NAND, 4b/512B, BCH ECC engine) [32 bits]

If you're interested, I have a mirabox with an armada 370 which uses the
same driver. I've not powered it up for a while but if that can be useful
I can try to find some time for this.

Just let me know
Willy

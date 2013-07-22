From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 22 Jul 2013 15:07:16 +0530
Subject: [PATCH v3 1/2] media: i2c: adv7343: make the platform data members
 as array
In-Reply-To: <1374301266-26726-2-git-send-email-prabhakar.csengg@gmail.com>
References: <1374301266-26726-1-git-send-email-prabhakar.csengg@gmail.com>
 <1374301266-26726-2-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <51ECFD4C.8020407@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 July 2013 11:51 AM, Lad, Prabhakar wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> 
> This patch makes the platform data members as array wherever
> possible, so as this makes easier while collecting the data
> in DT case and read the entire array at once.
> 
> This patch also makes appropriate changes to board-da850-evm.c
> 
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: linux-arm-kernel at lists.infradead.org

For the board-da850-evm.c change:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar

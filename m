From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Tue, 18 Jun 2013 14:15:13 +0530
Subject: [PATCH v2] ARM: edma: Convert to devm_* api
In-Reply-To: <51C01BC3.4060100@ti.com>
References: <1371481078-18058-1-git-send-email-prabhakar.csengg@gmail.com>
 <51C01BC3.4060100@ti.com>
Message-ID: <CA+V-a8szFcpxacZ3ERA3Sp7LP=fML3KaVyKtAL9K9tMwB3veNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar,

On Tue, Jun 18, 2013 at 2:05 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> On 6/17/2013 8:27 PM, Prabhakar Lad wrote:
>> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>>
>> Use devm_ioremap_resource instead of reques_mem_region()/ioremap(),
>> devm_request_irq() instead of request_irq() and kzalloc() calls to
>> devm_kzalloc().
>>
>> This ensures more consistent error values and simplifies error paths.
>>
>> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
>
> Nice clean-up. The patch did not build since <linux/err.h> was not
> included. I fixed it locally and applied to v3.11/soc-2 branch of my tree.
>
Thanks for fixing it.

Regards,
--Prabhakar Lad

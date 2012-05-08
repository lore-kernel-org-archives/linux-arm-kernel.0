From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 8 May 2012 11:39:41 +0530
Subject: [PATCH 1/7] ARM: OMAP4: Don't compile cm2xxx_3xxx.c for OMAP4
 only builds.
In-Reply-To: <alpine.DEB.2.00.1205072309190.9984@utopia.booyaka.com>
References: <1335952093-12541-1-git-send-email-santosh.shilimkar@ti.com>
 <1335952093-12541-2-git-send-email-santosh.shilimkar@ti.com>
 <alpine.DEB.2.00.1205072309190.9984@utopia.booyaka.com>
Message-ID: <CAMQu2gytRtL1p1jbnMM0rcem4crQycr0Y5DY4V_Ar5hCTh9ZBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 8, 2012 at 10:39 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 2 May 2012, Santosh Shilimkar wrote:
>
>> Since OMAP4 code base now makes use of OMAP4 specific PRCM functions,
>> cm2xxx_3xxx.c need not be compiled for OMAP4 only builds.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>
> Acked-by: Paul Walmsley <paul@pwsan.com>
>
> Will remove the stub functions in a separate patch.
>
ok

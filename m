From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 18 Oct 2015 11:22:46 +0200
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <20151015115825.GO3394@e106497-lin.cambridge.arm.com>
References: <1444904415-19597-1-git-send-email-linus.walleij@linaro.org>
 <20151015115825.GO3394@e106497-lin.cambridge.arm.com>
Message-ID: <CACRpkdazGsRuyuAL2oehc16KQcE5p9F==7XFZbD8uDpuNwEsTQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 1:58 PM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:

>> +                     flash at 0,00000000 {
>> +                             /* 2 * 32MiB NOR Flash memory mounted on CS0 */
>> +                             compatible = "arm,vexpress-flash", "cfi-flash";
>> +                             linux,part-probe = "afs";
>
> It would be nice if the linux,part-probe binding was documented somewhere.

Right, I only found it lying around in the kernel sourcetree
(drivers/mtd/maps/physmap_of.c) with no documentation
whatsoever.

I'll send a separate patch for this.

Yours,
Linus Walleij

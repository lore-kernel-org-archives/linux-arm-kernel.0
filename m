From: pullip.cho@samsung.com (KyongHo Cho)
Date: Thu, 22 Nov 2012 13:52:03 +0900
Subject: [PATCH v3 01/12] ARM: EXYNOS: remove system mmu initialization from
 exynos tree
In-Reply-To: <50ACF755.9000706@samsung.com>
References: <002701cdc7a5$756dbdf0$604939d0$%cho@samsung.com>
 <50ACF755.9000706@samsung.com>
Message-ID: <CAHQjnONNpk_jKtN3J38-t6hRwfq6LCyqwr=U8dwSKoQ+KcpZvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 12:46 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> On 11/21/12 14:02, Cho KyongHo wrote:
>>
>> This removes System MMU initialization from arch/arm/mach-exynos/
>
>
> Basically, looks OK to me, but I think, this removing change should be
done
> after 03/12 patch :-)
>
Thank you. I agree.
It will be moved to 03/12 patch as you mentioned.

>> to move them to DT and the exynos-iommu driver except gating clock
>> definitions.
>>
>> Change-Id: Ie29f587c01c645f28fc0e0b94eb3631a0170ebf5
>
>
> No need 'Change-Id' here.
>
That is my fault. It will be removed.

Thank you.

Cho KyongHo.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121122/2e1a76c0/attachment.html>

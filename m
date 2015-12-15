From: nm@ti.com (Nishanth Menon)
Date: Tue, 15 Dec 2015 08:49:07 -0600
Subject: [PATCH V2 1/3] ARM: multi_v7_defconfig: Enable beaglebone PMIC
 TPS65217
In-Reply-To: <20151215135100.GA8288@afzalpc>
References: <1450118580-24754-1-git-send-email-nm@ti.com>
 <1450118580-24754-2-git-send-email-nm@ti.com>
 <20151215135100.GA8288@afzalpc>
Message-ID: <CAGo_u6pGcKoz_Vw9hWtuDJ8RBr+N4=G0p5RgEAcjheoe4VXhvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 7:51 AM, Afzal Mohammed <afzal.mohd.ma@gmail.com> wrote:
> Hi,
>
> On Mon, Dec 14, 2015 at 12:42:58PM -0600, Nishanth Menon wrote:
>
>> Enable PMIC for beaglebone similar to commit 7a5c6065669c ("ARM:
>> OMAP2+: omap2plus_defconfig: Add tps65217 support") - this allows
>> multi_v7_defconfig to boot up on older beaglebone platforms.
>
> A similar one -
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/384289.html
>
> your v1 was earlier than the above, so mine should > /dev/null.

If you'd like to, please reply back on original patch dropping your
patch.. or if queued, I can drop mine (I dont see it on linux-next
yet).

>
> Seems Arnd wants multi_v7_defconfig changes thr' submaintainers rather
> than directly (which I initially thought was supposed to be done)

Just following what
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376637.html
was told. I am ok as all the submaintainers should be in CC of this
patch.

If you are ok with these patches, will appreciate to get a acked-by,
if you dont mind.

-- 
---
Regards,
Nishanth Menon

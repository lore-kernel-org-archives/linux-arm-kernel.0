From: pullip.cho@samsung.com (KyongHo Cho)
Date: Tue, 28 Feb 2012 01:04:25 +0900
Subject: [PATCH v8 0/2] ommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <000701ccf567$b9dee150$2d9ca3f0$%szyprowski@samsung.com>
References: <000e01ccc624$c9349310$5b9db930$%cho@samsung.com>
 <014601ccf2fa$a25c8560$e7159020$%szyprowski@samsung.com>
 <CAHQjnOPE5X=dn+8D348OruLqoYNGZwZk3eLtLRSERce-eTzXDg@mail.gmail.com>
 <000701ccf567$b9dee150$2d9ca3f0$%szyprowski@samsung.com>
Message-ID: <CAHQjnON=Q9oR5s1geO_MWeG0aKKrNkyqbS2RAD1deH22fj5T0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 12:51 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

>> The next patch will be submitted by 2/28.
>
> Ok, I will check it soon then.

Thank you a lot.

>> The next IOMMU driver defines just one platform device for a H/W device.
>> Thus, it defines just one SYSMMU_MFC platform device, for example.
>> (the previous one defines 2 platform devices for SYSMMU_MFC)
>
> Exynos4210 has 2 iommu controllers for MFC device - one for each memory bus.
> Each MFC bus can address 128MiB of IO address space. Do you mean that the new driver
> will merge these 2 controllers into one? This way we will lose half of address space
> for MFC device.

The situation seems somewhat different from our use of MFC. I also
heard from Jungtae Park
that it is better to define separate platform devices for the system
MMUs of MFC.

Regards,

Cho KyongHo.

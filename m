From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 29 Jan 2010 13:02:32 +0900
Subject: [PATCH v2 0/7] ARM: S5P6442: Add support for Samsung's S5P6442
	SoC
In-Reply-To: <000301caa08a$9f6a3830$de3ea890$%kim@samsung.com>
References: <000301caa08a$9f6a3830$de3ea890$%kim@samsung.com>
Message-ID: <9c9fda241001282002i41634063n4a78236568dfe24c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Are there other reason to crate the new s5p6442? Is any problem to use s5p6440?

As you said it's packages SoCs. based on s5p6440? isn't it?

Thank you,
Kyungmin Park

On Fri, Jan 29, 2010 at 11:27 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Hi All,
>
> This patches add basic support for Samsung's S5P6442 SoC.
> The feature set that is added are clock, timer, uart and interrupts.
>
> [PATCH v2 1/7] ARM: S5P6442: Add Samsung S5P6442 CPU support
> [PATCH v2 2/7] ARM: S5P6442: Add clock support for S5P6442
> [PATCH v2 3/7] ARM: S5P6442: Add IRQ support
> [PATCH v2 4/7] ARM: S5P6442: Update Kconfig and Makefiles
> [PATCH v2 5/7] ARM: S5P6442: Add SMDK6442 board support file
> [PATCH v2 6/7] ARM: S5P6442: Add S5P6442 configuration file
> [PATCH v2 7/7] ARM: S5P6442: Add serial port support
>
> Changes since v1:
> 1. Common macros are used such as S3C_PA_XXX and S3C_VA_XXX
> 2. Renamed S5P_VA_VICx definitions as VA_VICx
> 3. Removed unnecessary definitions in the header files like map.h
> 4. Added VIC2 definitions.
> 5. Fixed code as per comments from Ben in linux-samsung-soc mailing list.
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> System LSI Division, SAMSUNG ELECTRONICS CO., LTD.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

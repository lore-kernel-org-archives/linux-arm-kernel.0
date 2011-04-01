From: Ulrich.Weigand@de.ibm.com (Ulrich Weigand)
Date: Fri, 1 Apr 2011 19:02:05 +0200
Subject: [PATCH 1/2] ARM: ELF: Define new core note type for VFP registers
In-Reply-To: <1301674888-16842-2-git-send-email-dave.martin@linaro.org>
References: <1301674888-16842-1-git-send-email-dave.martin@linaro.org>
	<1301674888-16842-2-git-send-email-dave.martin@linaro.org>
Message-ID: <OF6081460F.2C1F93A0-ONC1257865.005D65F7-C1257865.005D9320@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dave Martin <dave.martin@linaro.org> wrote:

> diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
> index c3cd875..0b4872d 100644
> --- a/arch/arm/include/asm/elf.h
> +++ b/arch/arm/include/asm/elf.h
> @@ -62,6 +62,8 @@ typedef struct user_fp elf_fpregset_t;
>  #define R_ARM_THM_MOVW_ABS_NC   47
>  #define R_ARM_THM_MOVT_ABS   48
>
> +#define NT_ARM_VFP      0x400

This probably ought to go in include/elf.h, where all the
other NT_ types are defined ...


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand | Phone: +49-7031/16-3727
  STSM, GNU compiler and toolchain for Linux on System z and Cell/B.E.
  IBM Deutschland Research & Development GmbH
  Vorsitzender des Aufsichtsrats: Martin Jetter | Gesch?ftsf?hrung: Dirk
Wittkopp
  Sitz der Gesellschaft: B?blingen | Registergericht: Amtsgericht
Stuttgart, HRB 243294

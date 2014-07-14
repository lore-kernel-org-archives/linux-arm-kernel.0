From: will.deacon@arm.com (Will Deacon)
Date: Mon, 14 Jul 2014 14:36:44 +0100
Subject: [PATCH resend v2] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <1405079210-30044-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1405079210-30044-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140714133644.GE1779@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 12:46:50PM +0100, Ard Biesheuvel wrote:
> From: Yi Li <yi.li@linaro.org>
> 
> SMbios is important for server hardware vendors. It implements a spec for
> providing descriptive information about the platform. Things like serial
> numbers, physical layout of the ports, build configuration data, and the like.
> 
> This has been tested by dmidecode and lshw tools.
> 
> Signed-off-by: Yi Li <yi.li@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> Changes since previous version:
> - changed double inclusion guard to arm64 flavour
> - use kzalloc(GFP_KERNEL) as GFP_ATOMIC is not needed
> - do a sanity check on the size of the requested mapping

Technically, this patch looks fine to me:

  Reviewed-by: Will Deacon <will.deacon@arm.com>

It would be good if somebody with a relevant platform could confirm that
it works/is useful though.

Will

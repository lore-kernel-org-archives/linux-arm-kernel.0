From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 6 Oct 2014 11:40:25 +0100
Subject: [PATCHv4] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <1412437603-3394-1-git-send-email-yi.li@linaro.org>
References: <1412437603-3394-1-git-send-email-yi.li@linaro.org>
Message-ID: <20141006104024.GA487@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 04, 2014 at 04:46:43PM +0100, Yi Li wrote:
> SMBIOS is important for server hardware vendors. It implements a spec for
> providing descriptive information about the platform. Things like serial
> numbers, physical layout of the ports, build configuration data, and the like.
> 
> This has been tested by dmidecode and lshw tools.
> 
> Signed-off-by: Yi Li <yi.li@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> As Ard's suggestion, tested the patch on the kernel with/without EFI
> support to boot. The bootlog and dmidecode/lshw works fine.
> I will send the log with another email.

Thanks but it's late for 3.18. We'll probably queue it later for 3.19
(hopefully it's ok this time ;)).

-- 
Catalin

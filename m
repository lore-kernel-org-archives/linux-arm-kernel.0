From: lho@apm.com (Loc Ho)
Date: Thu, 25 Feb 2016 12:58:11 -0800
Subject: [PATCH v3] ARM64: kernel: implement ACPI parking protocol
In-Reply-To: <20160225092427.GA31728@red-moon>
References: <1453806638-23167-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20160202182657.GC15706@e104818-lin.cambridge.arm.com>
 <20160203112112.GA18387@red-moon>
 <20160203161834.GB26487@MBP.local>
 <20160224141832.GA26630@red-moon> <56CE3C9E.7070505@riken.jp>
 <20160225092427.GA31728@red-moon>
Message-ID: <CAPw-ZTmMVMztB6GTZPCtgoUKt9J2xAo1vBREzFZPUpZiS12Z+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> -- >8 --
> diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c

I applies this to 4.5.0-rc5-next-20160225+ and boot just fine on
Mustang and Merlin with 8 CPU's.

Tested-by: Loc Ho <lho@apm.com>

-Loc

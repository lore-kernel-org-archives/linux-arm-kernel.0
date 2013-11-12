From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 12 Nov 2013 20:34:36 +0400
Subject: [PATCH v2 0/5] ata: Add APM X-Gene SATA controller support
In-Reply-To: <3056580.hyyOnlSqg9@amdc1032>
References: <1383980431-6572-1-git-send-email-lho@apm.com>
 <3056580.hyyOnlSqg9@amdc1032>
Message-ID: <5282589C.2090606@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 12-11-2013 19:40, Bartlomiej Zolnierkiewicz wrote:

> Please remember to include linux-ide at vger.kernel.org on CC: for ATA patches.

> Also from the quick look it seems that:
> - patch #4 ("ata: Add APM X-Gene SATA serdes functions") should come before
>    patch #3 ("ata: Add APM X-Gene SATA driver") as code in patch #3 depends
>    on the code in patch #4
> - patch #5 ("Documentation: Add documentation for APM X-Gene SATA DTS
>    binding") should come before patch #2 ("arm64: Add APM X-Gene DTS entry
>    for SATA controllers") or (even better) just be merged into patch #2

    No, if it has to be merged then to the driver patch, not .dts patch.

> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics

WBR, Sergei

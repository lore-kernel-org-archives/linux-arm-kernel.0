From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Mar 2015 10:54:18 -0800
Subject: [PATCH v9 21/21] ARM64 / ACPI: additions of ACPI documentation
 for arm64
In-Reply-To: <1424853601-6675-22-git-send-email-hanjun.guo@linaro.org>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
 <1424853601-6675-22-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20150305185418.GG4932@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 04:40:01PM +0800, Hanjun Guo wrote:
> From: Al Stone <al.stone@linaro.org>
> 
> Two more documentation files are also being added:
> (1) A verbatim copy of the "Why ACPI on ARM?" blog posting by Grant Likely,
>     which is also summarized in arm-acpi.txt, and

This doesn't belong in the kernel tree.

> (2) A section by section review of the ACPI spec (acpi_object_usage.txt)
>     to note recommendations and prohibitions on the use of the numerous
>     ACPI tables and objects.  This sets out the current expectations of
>     the firmware by Linux very explicitly (or as explicitly as I can, for
>     now).

I'll follow up with any comments on this separately (I.e. haven't read it yet).


-Olof

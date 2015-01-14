From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 14 Jan 2015 15:59:07 +0530
Subject: [PATCH] arch: arm: mach-davinci: serial.c: Cleaning up function
 that are not used anywhere
In-Reply-To: <1417558120-26540-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1417558120-26540-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <54B644F3.2000906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 December 2014 03:38 AM, Rickard Strandqvist wrote:
> Remove function serial_read_reg() that is not used anywhere.
> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Queuing for v3.20 with subject updated to:

"ARM: davinci: serial.c: remove unused serial_read_reg()"

Thanks,
Sekhar

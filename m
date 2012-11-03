From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 3 Nov 2012 21:59:55 +0530
Subject: [PATCH 09/15] ARM: OMAP: AM33XX: Remove unnecessary include and
 use __ASSEMBLER__ macros
In-Reply-To: <1351859566-24818-10-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
 <1351859566-24818-10-git-send-email-vaibhav.bedia@ti.com>
Message-ID: <50954683.4050302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 November 2012 06:02 PM, Vaibhav Bedia wrote:
> Get rid of some unnecessary header file inclusions
> and also use __ASSEMBLER__ macros to allow the
> various register offsets from PM assembly code
> which be added in a subsequent patch.
>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

Ideally you should split header clean-up and assembler
fix in seperate patches.

Regards
Santosh

From: prabhakar@freescale.com (Prabhakar Kushwaha)
Date: Fri, 4 Jul 2014 06:10:59 +0530
Subject: [PATCH] arm64: PCI(e) arch support
In-Reply-To: <1404422876-1160-1-git-send-email-tinamdar@apm.com>
References: <1404422876-1160-1-git-send-email-tinamdar@apm.com>
Message-ID: <53B5F81B.8010801@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tanmay, Liviu,
On 7/4/2014 2:57 AM, Tanmay Inamdar wrote:
> Reposting on request of several people since previously posted one was
> corrupted.
>
> This patch adds the arch support for PCI(e) for arm64. The files
> added or modified in this patch are based on PCI(e) support in
> 32bit arm.
>
> Please note that this patch is just for the reference. Liviu Dudau from ARM
> has posted his v8 series of patch to support PCIe in arm64.
>
> The patch will apply against 3.13 Linux Kernel
>
> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>

do we foresee similar type of changes in u-boot  to support PCI(e) for 
ARM64.

Regards,
Prabhakar

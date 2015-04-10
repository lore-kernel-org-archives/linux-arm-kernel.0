From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 10 Apr 2015 12:03:28 +0100
Subject: [RFC PATCH 0/5] Add smp booting support for Qualcomm ARMv8 SoCs
In-Reply-To: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
References: <1428601031-5366-1-git-send-email-galak@codeaurora.org>
Message-ID: <20150410110328.GC25921@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 09, 2015 at 06:37:06PM +0100, Kumar Gala wrote:
> This patch set adds support for SMP boot on the MSM8x16 family of Qualcomm SoCs.
> 
> To support SMP on the MSM8x16 SoCs we need to add ARMv8/64-bit SCM interfaces to
> setup the boot/release addresses for the secondary CPUs.  In addition we need
> a uniquie set of cpu ops.  I'm aware the desired methods for booting secondary
> CPUs is either via spintable or PSCI.  However, these SoCs are shipping with a
> firmware that does not support those methods.

Why ? Do not tell me you were not aware of those standard methods,
because I can't believe you.

If there were additional features to add to spin-table and PSCI,
you were, you are and you will always be welcome to debate them.

There is no justification for this patchset, honestly.

Lorenzo

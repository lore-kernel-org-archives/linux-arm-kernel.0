From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 12 Feb 2018 08:43:45 -0600
Subject: [PATCH] acpi, spcr: Make SPCR available to x86
In-Reply-To: <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
References: <20180118150951.28964-1-prarit@redhat.com>
 <20180212133429.GC25314@hirez.programming.kicks-ass.net>
 <1e69fffc-1c3b-8cc0-f1cb-695de5ccdcb5@redhat.com>
Message-ID: <953565bd-436b-c1fe-d3c5-cde731dee83d@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/12/18 7:47 AM, Prarit Bhargava wrote:
> ACPI SPCR is used by a vendor to define the serial console for a system.  If
> SPCR exists a user can add kernel parameter "earlycon" (no extra kernel
> parameters) and the console will work out-of-the-box.

"earlycon" is needed only for an *early* console.  You don't need any 
command line parameters for a normal console to work with SPCR.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

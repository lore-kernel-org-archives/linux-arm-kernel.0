From: sid@reserved-bit.com (Siddhesh Poyarekar)
Date: Wed, 28 Oct 2015 14:23:13 +0530
Subject: [PATCH v3 00/24] arm64: Consolidate CPU feature handling
In-Reply-To: <562FBDD4.5030309@arm.com>
References: <1444756952-31145-1-git-send-email-suzuki.poulose@arm.com>
 <562C8D68.9040008@reserved-bit.com> <562FBDD4.5030309@arm.com>
Message-ID: <56308CF9.8080206@reserved-bit.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 October 2015 11:39 PM, Suzuki K. Poulose wrote:
> I am afraid that would impose a new ABI with complications on how we
> handle information about the CPUs in different states (online, offline,
> etc). I am open to suggestions here.

No I agree it would be non-trivial to maintain this information in a
single file.  Nor does it solve my problem completely based on the
context you give below, so it's not worth spending time on.

> See [1] for previous discussion on this topic.
> 
> [1] https://lkml.org/lkml/2015/9/1/391

Thank you for the context.  Somehow I was expecting information for all
configured processors (as opposed to only online ones) to be available
at boot time inside sysfs, but clearly that is not going to happen.  Let
me see if I can think of a way to use this information in glibc.

Thanks,
Siddhesh

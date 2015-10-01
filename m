From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 1 Oct 2015 16:15:14 +0100
Subject: [Xen-devel] [PATCH v5 00/22] xen/arm64: Add support for 64KB
 page in Linux
In-Reply-To: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
Message-ID: <560D4E02.60700@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/15 11:45, Julien Grall wrote:
> Hi all,
> 
> ARM64 Linux is supporting both 4KB and 64KB page granularity. Although, Xen
> hypercall interface and PV protocol are always based on 4KB page granularity.
> 
> Any attempt to boot a Linux guest with 64KB pages enabled will result to a
> guest crash.
> 
> This series is a first attempt to allow those Linux running with the current
> hypercall interface and PV protocol.
> 
> This solution has been chosen because we want to run Linux 64KB in released
> Xen ARM version or/and platform using an old version of Linux DOM0.

Applied to for-linus-4.4, thanks.

Boris, can you kick off a set of tests for this branch, please?

David

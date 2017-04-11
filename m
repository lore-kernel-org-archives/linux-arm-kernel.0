From: jcm@redhat.com (Jon Masters)
Date: Tue, 11 Apr 2017 15:12:57 -0400
Subject: [GIT PULL] arm64: fixes for -rc6
In-Reply-To: <20170407160239.GS19342@arm.com>
References: <20170407160239.GS19342@arm.com>
Message-ID: <3b32cfd3-7675-005b-a737-58a8677f65ac@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2017 12:02 PM, Will Deacon wrote:

> Please pull these two arm64 fixes for -rc6. We've got a regression fix for
> the signal raised when userspace makes an unsupported unaligned access and a
> revert of the contiguous (hugepte) support for hugetlb, which has once again
> been found to be broken. One day, maybe, we'll get it right.

<snip>

> - Revert broken support for the contiguous bit in hugetlb (again...)

Quick aside: is this being worked on for 4.12? If not, should we ping
Linaro and look to get some focus on this? It's right to disable this,
but also painful to those wanting to work on various NFV use cases.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop

From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 19 Jun 2017 15:01:33 -0700
Subject: [PATCH v5 0/8] Support for contiguous pte hugepages
In-Reply-To: <20170619170145.25577-1-punit.agrawal@arm.com>
References: <20170619170145.25577-1-punit.agrawal@arm.com>
Message-ID: <20170619150133.cb4173220e4e3abd02c6f6d0@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 19 Jun 2017 18:01:37 +0100 Punit Agrawal <punit.agrawal@arm.com> wrote:

> This is v5 of the patchset to update the hugetlb code to support
> contiguous hugepages. Previous version of the patchset can be found at
> [0].

Dumb question: is there a handy description anywhere which describes
how arm64 implements huge pages?  "contiguous 4k ptes" doesn't sound
like a huge page at all - what's going on here?

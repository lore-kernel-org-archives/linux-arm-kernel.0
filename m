From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 6 Nov 2012 14:38:26 -0800
Subject: [PATCH 09/16] mm: use vm_unmapped_area() in hugetlbfs on i386
 architecture
In-Reply-To: <1352155633-8648-10-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
 <1352155633-8648-10-git-send-email-walken@google.com>
Message-ID: <20121106143826.dc3b960c.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  5 Nov 2012 14:47:06 -0800
Michel Lespinasse <walken@google.com> wrote:

> Update the i386 hugetlb_get_unmapped_area function to make use of
> vm_unmapped_area() instead of implementing a brute force search.

The x86_64 coloring "fix" wasn't copied into i386?

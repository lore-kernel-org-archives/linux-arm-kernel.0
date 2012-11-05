From: riel@redhat.com (Rik van Riel)
Date: Mon, 05 Nov 2012 18:33:42 -0500
Subject: [PATCH 08/16] mm: use vm_unmapped_area() in hugetlbfs
In-Reply-To: <1352155633-8648-9-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
 <1352155633-8648-9-git-send-email-walken@google.com>
Message-ID: <50984CD6.9090204@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2012 05:47 PM, Michel Lespinasse wrote:
> Update the hugetlb_get_unmapped_area function to make use of
> vm_unmapped_area() instead of implementing a brute force search.
>
> Signed-off-by: Michel Lespinasse <walken@google.com>

Reviewed-by: Rik van Riel <riel@redhat.com>

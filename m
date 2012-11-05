From: riel@redhat.com (Rik van Riel)
Date: Mon, 05 Nov 2012 18:34:34 -0500
Subject: [PATCH 10/16] mm: use vm_unmapped_area() on mips architecture
In-Reply-To: <1352155633-8648-11-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
 <1352155633-8648-11-git-send-email-walken@google.com>
Message-ID: <50984D0A.3000608@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2012 05:47 PM, Michel Lespinasse wrote:
> Update the mips arch_get_unmapped_area[_topdown] functions to make
> use of vm_unmapped_area() instead of implementing a brute force search.
>
> Signed-off-by: Michel Lespinasse <walken@google.com>

Reviewed-by: Rik van Riel <riel@redhat.com>

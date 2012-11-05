From: riel@redhat.com (Rik van Riel)
Date: Mon, 05 Nov 2012 18:35:39 -0500
Subject: [PATCH 11/16] mm: use vm_unmapped_area() on arm architecture
In-Reply-To: <1352155633-8648-12-git-send-email-walken@google.com>
References: <1352155633-8648-1-git-send-email-walken@google.com>
 <1352155633-8648-12-git-send-email-walken@google.com>
Message-ID: <50984D4B.6090501@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2012 05:47 PM, Michel Lespinasse wrote:
> Update the arm arch_get_unmapped_area[_topdown] functions to make
> use of vm_unmapped_area() instead of implementing a brute force search.
>
> Signed-off-by: Michel Lespinasse <walken@google.com>

Reviewed-by: Rik van Riel <riel@redhat.com>

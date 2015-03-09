From: schwidefsky@de.ibm.com (Martin Schwidefsky)
Date: Mon, 9 Mar 2015 10:41:36 -0700
Subject: [PATCH v4 06/10] s390: standardize mmap_rnd() usage
In-Reply-To: <1425503454-7531-7-git-send-email-keescook@chromium.org>
References: <1425503454-7531-1-git-send-email-keescook@chromium.org>
 <1425503454-7531-7-git-send-email-keescook@chromium.org>
Message-ID: <20150309104136.4abdf1bd@mschwide>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  4 Mar 2015 13:10:50 -0800
Kees Cook <keescook@chromium.org> wrote:

> In preparation for splitting out ET_DYN ASLR, this refactors the use of
> mmap_rnd() to be used similarly to arm and x86, and extracts the checking
> of PF_RANDOMIZE.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/s390/mm/mmap.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)

Patch series including this patch works fine
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 9 Feb 2017 13:17:23 +0100
Subject: [PATCH v3] staging: bcm2835-audio: Remove the initialization of
 static pointers.
In-Reply-To: <1486511160-2992-1-git-send-email-abdallah.meziti.pro@gmail.com>
References: <1486511160-2992-1-git-send-email-abdallah.meziti.pro@gmail.com>
Message-ID: <20170209121723.GA32270@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2017 at 12:45:47AM +0100, AbdAllah-MEZITI wrote:
> In C a static pointer will be initialized to NULL.
> The ?6.7.8 of the ISO/IEC 9899:1999 (E) document says that:
> If an object that has static storage duration is not initialized
> explicitly, then:
>  __ if it has pointer type, it is initialized to a null pointer.
> 
> Signed-off-by: AbdAllah-MEZITI <abdallah.meziti.pro@gmail.com>
> 
> v2: -fix the line-wrapping of the changelog.
>     -fix the ref. documentation: C99 standards release,
> 	and not the draft.
>     -this patch is the Task 10 Eudyptula Challenge
> 	that only fix one code style problem.
> v3: -fix the subject prefix: must be based on the previous submissions.
> ---
>  drivers/staging/bcm2835-audio/bcm2835.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

This patch does not apply to my tree at all, sorry.

greg k-h

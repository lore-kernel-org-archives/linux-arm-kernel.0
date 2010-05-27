From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Thu, 27 May 2010 10:09:23 -0700 (PDT)
Subject: [PATCH v3] net/fec: fix pm to survive to suspend/resume
In-Reply-To: <1274969989-4280-1-git-send-email-eric@eukrea.com>
Message-ID: <536177.31761.qm@web51001.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric,

--- On Thu, 5/27/10, Eric B?nard <eric@eukrea.com> wrote:

> From: Eric B?nard <eric@eukrea.com>
> Subject: [PATCH v3] net/fec: fix pm to survive to suspend/resume
> To: linux-arm-kernel at lists.infradead.org
> Cc: s.hauer at pengutronix.de, sshtylyov at mvista.com
> Date: Thursday, May 27, 2010, 11:19 AM
> * with this patch, if the connection
> if active before suspend, it
> will be active after resume.
> * before this patch, it was necessary to close the
> interface and
> reopen it to recover the connection.
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> ---
> v3 : fix following Sergei Shtylyov's comments
> 
>  drivers/net/fec.c |???10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/fec.c b/drivers/net/fec.c
> index 9b4e8f7..1521972 100644
> --- a/drivers/net/fec.c
> +++ b/drivers/net/fec.c

I think you should have CC'ed the linux-netdev list also.

Regards,

Fabio Estevam


      

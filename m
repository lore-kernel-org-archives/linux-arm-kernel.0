From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 9 Mar 2011 13:56:31 +0800
Subject: [PATCH] net/fec: check id_entry pointer before using it
In-Reply-To: <1299639004-21546-1-git-send-email-jason.hui@linaro.org>
References: <1299639004-21546-1-git-send-email-jason.hui@linaro.org>
Message-ID: <20110309055630.GA2556@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Wed, Mar 09, 2011 at 10:50:04AM +0800, Jason Liu wrote:
> The id_entry will possibly be NULL, So, need check
> id_entry and make sure it not NULL before using it.
> 
> Signed-off-by: Jason Liu <r64343@freescale.com>
> ---
>  drivers/net/fec.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
You need to cc list: netdev at vger.kernel.org

-- 
Regards,
Shawn

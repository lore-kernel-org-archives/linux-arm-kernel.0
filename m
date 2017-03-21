From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Tue, 21 Mar 2017 08:37:01 +0100
Subject: [PATCH] vc04_services: Fixing coding guideline error
In-Reply-To: <1489559468-46932-1-git-send-email-pushkar.iit@gmail.com>
References: <1489559468-46932-1-git-send-email-pushkar.iit@gmail.com>
Message-ID: <20170321073701.GA18533@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 12:01:08PM +0530, Pushkar Jambhlekar wrote:
> Fixing 'if' block coding style. '{' should follow 'if' for multiline block
> 
> Signed-off-by: Pushkar Jambhlekar <pushkar.iit@gmail.com>
> ---
>  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch does not apply to my tree at all, please rebase and refresh and
resend.

thanks,

greg k-h

From: gregkh@linuxfoundation.org (Greg KH)
Date: Sat, 24 Jun 2017 00:20:55 +0800
Subject: [PATCH] Staging: vc04_services: bcm2835-audio: bcm2835-ctl.c:
 Fixed alignment to match open parenthesis
In-Reply-To: <1497468895-3061-1-git-send-email-srishtishar@gmail.com>
References: <1497468895-3061-1-git-send-email-srishtishar@gmail.com>
Message-ID: <20170623162055.GB21608@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 15, 2017 at 01:04:55AM +0530, srishti sharma wrote:
> Fixed alignment so that it matched open parenthesis.
> 
> Signed-off-by: srishti sharma <srishtishar@gmail.com>
> ---
>  .../staging/vc04_services/bcm2835-audio/bcm2835-ctl.c  | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

What differs from your previous patch?  Always properly version your
patch so we know what to take.

Please fix and resend.

thanks,

greg k-h

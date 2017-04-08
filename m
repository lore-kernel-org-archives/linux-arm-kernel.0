From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 8 Apr 2017 16:59:07 +0200
Subject: [PATCH v2] staging: bcm2835-audio: remove unnecessary log messages
In-Reply-To: <20170403183343.GA3620@aishwarya>
References: <20170403183343.GA3620@aishwarya>
Message-ID: <20170408145907.GA3789@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 04, 2017 at 12:03:43AM +0530, Aishwarya Pant wrote:
> Remove unnecessary log messages in the driver which are just tracking
> function entry and exits.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> ---
> Changes in v2:
> Patch v1 introduced a compile error; remove it by deleting the log
> continuation.
> 
>  .../vc04_services/bcm2835-audio/bcm2835-ctl.c      |  2 --
>  .../vc04_services/bcm2835-audio/bcm2835-pcm.c      | 19 -----------
>  .../vc04_services/bcm2835-audio/bcm2835-vchiq.c    | 38 ----------------------
>  3 files changed, 59 deletions(-)

Doesn't apply against my tree at all :(

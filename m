From: cjb@laptop.org (Chris Ball)
Date: Thu, 01 Dec 2011 13:47:12 -0500
Subject: [PATCH 20/62] mmc: remove the second argument of k[un]map_atomic()
In-Reply-To: <1322371662-26166-21-git-send-email-amwang@redhat.com> (Cong
 Wang's message of "Sun, 27 Nov 2011 13:27:00 +0800")
References: <1322371662-26166-1-git-send-email-amwang@redhat.com>
 <1322371662-26166-21-git-send-email-amwang@redhat.com>
Message-ID: <87vcq0jfin.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Nov 27 2011, Cong Wang wrote:
> Signed-off-by: Cong Wang <amwang@redhat.com>
> ---
>  drivers/mmc/host/at91_mci.c |    8 ++++----
>  drivers/mmc/host/msm_sdcc.c |    6 +++---
>  drivers/mmc/host/sdhci.c    |    4 ++--
>  drivers/mmc/host/tifm_sd.c  |   16 ++++++++--------
>  drivers/mmc/host/tmio_mmc.c |    1 -
>  drivers/mmc/host/tmio_mmc.h |    4 ++--
>  6 files changed, 19 insertions(+), 20 deletions(-)

Looks good, thanks, pushed to mmc-next for 3.3.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child

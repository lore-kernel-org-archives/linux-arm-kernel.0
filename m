From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 30 Nov 2015 20:04:46 +0100
Subject: [PATCH 2/3] rtc: sunxi: constify the data_year_param structure
In-Reply-To: <1447930210-27008-2-git-send-email-clabbe.montjoie@gmail.com>
References: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com>
 <1447930210-27008-2-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20151130190446.GL22136@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/2015 at 11:50:09 +0100, LABBE Corentin wrote :
> The data_year_param struct is never modified, so lets constify it.
> This permit to remove cast since of_device_id is const also.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/rtc/rtc-sunxi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

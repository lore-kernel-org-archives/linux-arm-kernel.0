From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 30 Nov 2015 20:05:11 +0100
Subject: [PATCH 3/3] rtc: sunxi: use of_device_get_match_data
In-Reply-To: <1447930210-27008-3-git-send-email-clabbe.montjoie@gmail.com>
References: <1447930210-27008-1-git-send-email-clabbe.montjoie@gmail.com>
 <1447930210-27008-3-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20151130190511.GM22136@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/11/2015 at 11:50:10 +0100, LABBE Corentin wrote :
> The usage of of_device_get_match_data reduce the code size a bit.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/rtc/rtc-sunxi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

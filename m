From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 07 Apr 2015 23:37:30 +0200
Subject: [PATCH v4 4/4] ARM: dts: Specify VMMC and VQMMC on rk3288-evb
In-Reply-To: <10565603.LCTpLmy44N@phil>
References: <1426112117-18220-1-git-send-email-dianders@chromium.org>
 <1426112117-18220-4-git-send-email-dianders@chromium.org>
 <10565603.LCTpLmy44N@phil>
Message-ID: <1457117.iiJ36z7dmV@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 12. M?rz 2015, 00:30:14 schrieb Heiko Stuebner:
> Am Mittwoch, 11. M?rz 2015, 15:15:17 schrieb Doug Anderson:
> > Specifying these rails should eventually let us do UHS.
> > 
> > Signed-off-by: Doug Anderson <dianders@chromium.org>
> 
> This one looks good to me and I'll take it into my dts branch.
> 
> But due to the deferal issue fixed in patch1, I'll wait a bit for patch1
> hopefully getting applied, so that we have a "clean" behaviour when
> everything reaches linux-next.

looks like patch1 made it into the mmc tree [0], which was the prequisite for 
this one. Therefore applied to my dts branch.


Heiko


[0] 
https://git.linaro.org/people/ulf.hansson/mmc.git/commit/b793f658b194edfe5e1d86aaeace01a7b03c68f9

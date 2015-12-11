From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 12 Dec 2015 00:08:17 +0100
Subject: [PATCH] arm: dts: rockchip: Fix typo in rk32288 sdmmc card detect
 pin name
In-Reply-To: <1449845158-8284-1-git-send-email-mbrugger@suse.com>
References: <1449845158-8284-1-git-send-email-mbrugger@suse.com>
Message-ID: <1649282.ILIgoNi0K6@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

Am Freitag, 11. Dezember 2015, 15:45:58 schrieb Matthias Brugger:
> The card detect pin is currently called sdmcc-cd.
> This patch fixes the typo and renames the pin to sdmmc-cd.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

applied to my dts32 branch for 4.5, after fixing the rk32288 in the subject


Thanks
Heiko

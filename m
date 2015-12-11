From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 11 Dec 2015 15:35:04 +0100
Subject: [PATCH] arm64: dts: Fix typo in rk3368 card detect binding
In-Reply-To: <1449840139-32420-1-git-send-email-mbrugger@suse.com>
References: <1449840139-32420-1-git-send-email-mbrugger@suse.com>
Message-ID: <8411276.uRATKJsWEo@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

Am Freitag, 11. Dezember 2015, 14:22:19 schrieb Matthias Brugger:
> The card detect pin is called sdmcc-cd.
> This patch fixes the typo and renames the pin to sdmmc-cd.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>

applied to my arm64 dts branch, after fixing up the subject.


Thanks
Heiko

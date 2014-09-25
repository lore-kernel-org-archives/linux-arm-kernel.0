From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Sep 2014 23:29:02 +0200
Subject: [PATCH] ARM: bcm2835: enable USB_DWC2_HOST in defconfig
In-Reply-To: <1410918724-22752-1-git-send-email-swarren@wwwdotorg.org>
References: <1410918724-22752-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201409252329.02619.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 17 September 2014, Stephen Warren wrote:
> From: Lubomir Rintel <lkundrak@v3.sk>
> 
> It broke when host was moved into a separate module, in 47a1685 ("usb:
> dwc2/s3c-hsotg: move s3c-hsotg into dwc2 directory"),
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> These two patches are all I expect to have for RPi for 3.18, so I figure
> it's easiest to just forward them on to you rather than sending tiny pull
> requests.
> 

Applied to next/defconfig.

BTW, I wonder if we should add a multi_v6_defconfig that has this and other
platforms enabled, or possibly a multi_v6plus_defconfig that is also a superset
of multi_v7_defconfig. Nothing to worry about on your end, but it seems
weird to have it for v7 and v5 but not v6.

	Arnd

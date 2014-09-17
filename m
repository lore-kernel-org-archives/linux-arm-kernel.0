From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Sep 2014 19:53:38 -0600
Subject: [PATCH] ARM: bcm2835: Enable USB_DWC2_HOST in bcm2835_defconfig
In-Reply-To: <1410878435-12499-1-git-send-email-lkundrak@v3.sk>
References: <1410878435-12499-1-git-send-email-lkundrak@v3.sk>
Message-ID: <5418E9A2.3090304@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2014 08:40 AM, Lubomir Rintel wrote:
> It broke when host was moved into a separate module, in [47a1685f1].
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

I've forwarded this patch to armsoc to be applied.

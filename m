From: info@lategoodbye.de (Stefan Wahren)
Date: Sun, 11 Oct 2015 14:39:25 +0200
Subject: bcm2835 (Raspberry Pi) KMS driver
In-Reply-To: <1444426068-15817-1-git-send-email-eric@anholt.net>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
Message-ID: <561A587D.6020009@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 09.10.2015 um 23:27 schrieb Eric Anholt:
> This is a respin of the Raspberry Pi KMS series.  Now that we've got a
> real clock driver, I can actually set new video modes.  Also in this
> version, most of the custom DT stuff from before is gone, thanks to
> finding exynos's platform_driver component matching code (I have sent
> separate patches to drivers/base to make helpers for doing it).
>
> https://github.com/anholt/linux/tree/vc4-kms-squash-2
>
>

I want to point out that git format-patch could prepare a nice cover 
letter and usually the changelog should go there.

Regards
Stefan

From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 8 Mar 2018 13:27:15 +0100
Subject: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Message-ID: <20180308122715.GB21514@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Resent without non-upstream patches.
> 
> This backport patchset fixed the spectre issue, it's original branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
> A few dependency or fixingpatches are also picked up, if they are necessary
>  and no functional changes.
> 
> No bug found from kernelci.org and lkft testing. It also could be gotten from:
> 
> git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upstream-only
> 
> Comments are appreciated!

Not entirely related to this patched, but... I have few older ARM
boards here, and Nokia N9000 I really care about.

AFAICT Meltdown is arm64 only?

Spectre affects the older boards, too, right? Was there any work done
on that? cpuinfo says "ARMv7" for N900.

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180308/cc1438e6/attachment.sig>

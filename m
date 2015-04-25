From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 25 Apr 2015 14:23:39 +0200 (CEST)
Subject: [PATCH v3 0/2] clk: improve handling of orphan clocks
In-Reply-To: <1429735986-18592-1-git-send-email-heiko@sntech.de>
References: <1429735986-18592-1-git-send-email-heiko@sntech.de>
Message-ID: <380631359.469897.1429964620007.JavaMail.open-xchange@oxbaltgw01.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

> Heiko Stuebner <heiko@sntech.de> hat am 22. April 2015 um 22:53 geschrieben:
>
>
> Using orphan clocks can introduce strange behaviour as they don't have
> rate information at all and also of course don't track
>
> [...]
>
>
> As this changes the behaviour for orphan clocks, it would of course
> benefit from more testing than on my Rockchip boards. To keep the
> recipent-list reasonable and not spam to much I selected one (the topmost)
> from the get_maintainer output of each drivers/clk entry.
> Hopefully some will provide Tested-by-tags :-)
>

excuse me for my naive question, but what kind of tests do you expect (beside
applying the patches)?

Stefan

>
> Thanks
> Heiko
>

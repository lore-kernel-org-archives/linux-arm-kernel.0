From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 19 Sep 2016 13:00:51 +0200
Subject: [PATCH v4 0/7] ARM: dts: bcm283x: add and use pinctrl groups
In-Reply-To: <1474274603-24215-1-git-send-email-kraxel@redhat.com>
References: <1474274603-24215-1-git-send-email-kraxel@redhat.com>
Message-ID: <c7b43dbc-7bfc-0aa6-b451-4ef9a11e456e@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 19.09.2016 um 10:43 schrieb Gerd Hoffmann:
>   Hi,
>
> New in v4:  Patch #6 has been splitted into two:  Patch 6 just moves
> pinctrl from &gpio to &sdhci.  Removing the empty now alt3 group
> -- including all references as pointed out by Stefan Wahren in review --
> is done by the new patch 7.  Patches 1-5 are unchanged.

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

for the whole series.

Thanks
Stefan

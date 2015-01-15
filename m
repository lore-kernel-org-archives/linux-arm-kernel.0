From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Jan 2015 13:30:13 +0100
Subject: [PATCH net-next v13 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <54B796A3.7040200@huawei.com>
References: <1421217254-12008-1-git-send-email-dingtianhong@huawei.com>
 <1421253246.11734.17.camel@edumazet-glaptop2.roam.corp.google.com>
 <54B796A3.7040200@huawei.com>
Message-ID: <1848773.hOchPbb3Eb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 January 2015 18:29:55 Ding Tianhong wrote:
> 
> Yes, thanks, fix them later.

Please note that now that as v13 has now shown up in net-next, I guess
all other patches need to be based on top of what is already merged,
and address one issue at a time.

There is one more issue I saw during build testing, which is the
lack of a MODULE_LICENSE  statement for the main driver, although
there is one in the mdio driver.

	Arnd

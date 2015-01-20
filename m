From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Jan 2015 22:37:14 +0100
Subject: [PATCH V2 1/2] ARM: BCM5301X: Enable earlyprintk on tested devices
In-Reply-To: <54BEC49F.7030405@hauke-m.de>
References: <1421735096-8238-1-git-send-email-zajec5@gmail.com>
 <1421735762-8475-1-git-send-email-zajec5@gmail.com>
 <54BEC49F.7030405@hauke-m.de>
Message-ID: <3431445.qSs2tca53I@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 January 2015 22:11:59 Hauke Mehrtens wrote:
> On 01/20/2015 07:36 AM, Rafa? Mi?ecki wrote:
> > Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> > ---
> > V2: Typo in commit message: s/BCM5310X/BCM5301X/
> > ---
> 
> In this pull request Arnd said that enabling early printk is a bad idea:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304438.html
> 

To clarify my comment from back then: earlycon support for ARM did *not*
make it into 3.19, although I think it works on x86, arm64 and mips.

I hope this gets resolved for 3.20.

	Arnd

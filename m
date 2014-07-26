From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 26 Jul 2014 12:18:08 +0200
Subject: [GIT PULL][for 3.17] ARM:hisi: pull request for fixing hisilicon
 hi3620 soc
In-Reply-To: <53D1F2F6.7000208@hisilicon.com>
References: <53D1F2F6.7000208@hisilicon.com>
Message-ID: <6671154.IXq5eQN1tZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 July 2014 14:02:30 xuwei wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Resend it again and add arm at kernel.org into the CC list.
> Please help to merge pull request for fixing L2 address for Hi3620 SoC. 
> 
> 

I've cherry-picked the patch in order to add a 'Cc: stable at vger.kernel.org'
tag so the fix gets included in the longterm-3.14 kernel.

Please have a look at whether bug fixes need back-porting in the future,
and mark them accordingly.

Thanks,

	Arnd

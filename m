From: davem@davemloft.net (David Miller)
Date: Tue, 02 Dec 2014 20:32:52 -0800 (PST)
Subject: [PATCH, regression against -rc6] net/stmmac: fix one more
 regression from filter bins setting
In-Reply-To: <5807934.FFPy2gmHBj@wuerfel>
References: <5388366.Y15J6TLmlA@wuerfel>
 <tencent_0FE25D6968E3D939662D9E00@qq.com>
 <5807934.FFPy2gmHBj@wuerfel>
Message-ID: <20141202.203252.1622139877301467504.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 29 Nov 2014 17:26:42 +0100

> On Saturday 29 November 2014 23:44:23 ??? wrote:
>> Hi, Arnd,
>> 
>> Maybe this patch is better?
>> http://www.spinics.net/lists/netdev/msg306413.html
> 
> Yes, that would work too. I also checked that my version works now.
> 
> I'm fine with either one, as long as a fix makes it into 3.18.

It's in the 'net' tree, I'll try to get it to Linus soon.

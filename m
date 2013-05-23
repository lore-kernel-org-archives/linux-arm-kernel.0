From: b32955@freescale.com (Huang Shijie)
Date: Thu, 23 May 2013 10:17:16 +0800
Subject: [PATCH 1/6] drivers: bus: add a new driver for WEIM
In-Reply-To: <201305221459.34859.arnd@arndb.de>
References: <1369039742-10893-1-git-send-email-b32955@freescale.com>
 <20130521054323.GE3080@S2101-09.ap.freescale.net>
 <519C7ED3.3030004@freescale.com> <201305221459.34859.arnd@arndb.de>
Message-ID: <519D7C2C.9080506@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2013?05?22? 20:59, Arnd Bergmann ??:
> On Wednesday 22 May 2013, Huang Shijie wrote:
>> ? 2013?05?21? 13:43, Shawn Guo ??:
>>> It seems we can find it out from "reg" property, so that we can save
>>> this property?
>>>
>> we may have several devices attaching to the weim, each device has its 
>> own CS index.
>> it's better to keep this property, make it more clear.
> I agree with Shawn, we should not have this property when it is the
> same as the upper half of the "reg" property.
okay. I will remove this property.

thanks
Huang Shijie

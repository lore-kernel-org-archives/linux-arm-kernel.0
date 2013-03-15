From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 16 Mar 2013 01:24:44 +0300
Subject: [RFC] USB: EHCI: hot-fix OMAP and Orion multiplatform config
In-Reply-To: <201303152111.09705.arnd@arndb.de>
References: <Pine.LNX.4.44L0.1303151516170.1414-100000@iolanthe.rowland.org>
 <201303152015.31292.arnd@arndb.de> <51439BDF.3050300@cogentembedded.com>
 <201303152111.09705.arnd@arndb.de>
Message-ID: <51439FAC.4000300@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/16/2013 12:11 AM, Arnd Bergmann wrote:

> On Friday 15 March 2013, Sergei Shtylyov wrote:
>>> a) Apply Roger's patch for 3.9, and add my "USB: EHCI: DT support
>>>      for generic bus glue" patch on top after it has been tested
>>      Arnd, sorry, where can I find this patch? Archive search doesn't
>> turn up anything...
> It's in this email thread, in one of my earlier replies to Alan.

    Ah, found it now. I thought however that it already handles the DT 
properties for the EHCI platform data.
Of course, that can be added later...

WBR, Sergei

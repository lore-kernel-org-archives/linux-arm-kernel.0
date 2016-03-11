From: blogic@openwrt.org (John Crispin)
Date: Fri, 11 Mar 2016 07:48:39 +0100
Subject: [OpenWrt-Devel] ARMv4 (not v4t) marked obsolete in gcc-6
In-Reply-To: <alpine.LNX.2.00.1603110638190.12310@T520.work>
References: <201603101013.04618.arnd@arndb.de>
 <alpine.LNX.2.00.1603110638190.12310@T520.work>
Message-ID: <56E26A47.9040608@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/03/2016 06:44, Hans Ulli Kroll wrote:
> Hi
>>
>> * Gemini: officially supported in OpenWRT today, with the latest compiler. This one
>>   will likely cause the most issues for actual users. It would be helpful to get
>>   some numbers about users or downloads here, to see whether it can be dropped
>>   in a future OpenWRT release or if it might be possible to leave this on
>>   gcc-6.x when the other platforms move on to gcc-7+
> 
> I don't have any numbers from the OPenWRT people.
> For the NAS BOXes itself, I get one/two support questions a month on the 
> german based forum.
> I think most people know about the SATA bug, which makes the platform 
> unreliable for some SATA drives.
> y
> Hans Ulli

Hi,

We have several active users. Roman has done a great job to constantly
maintain and update the target. We have been including gemini in our
releases for years thanks to Romans effort. It would be a shame to to
see support being dropped, even if there are few yet active users.

	John

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 09 Jul 2013 10:05:01 -0600
Subject: CPU hotplug issue w/ 0647065 clocksource: Add generic dummy timer
 driver
In-Reply-To: <20130709005837.GC830@codeaurora.org>
References: <51DAF895.1020700@wwwdotorg.org>
 <20130709005837.GC830@codeaurora.org>
Message-ID: <51DC34AD.30009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2013 06:58 PM, Stephen Boyd wrote:
> On 07/08, Stephen Warren wrote:
>> CPU hotplug (replug) on Tegra HW seems to be occasionally broken due to
>> commit 0647065 "clocksource: Add generic dummy timer driver" in
>> linux-next. Reverting that commit solves the issue.
> 
> We found some breakage during boot that has been fixed by two
> commits in linus' tree already. Do you know if you have these two
> patches
> 
> 1f73a9806bdd07a5106409bbcab3884078bd34fe
> 07bd1172902e782f288e4d44b1fde7dec0f08b6f

I didn't before since I was using next-20130705, but I just tried
next-20130709 which does have those two commits, and I still see the issue.

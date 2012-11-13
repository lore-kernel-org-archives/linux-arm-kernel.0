From: johnstul@us.ibm.com (John Stultz)
Date: Tue, 13 Nov 2012 10:57:32 -0800
Subject: [PATCH V2 3/3] clocksource: time-armada-370-xp converted to clk
 framework
In-Reply-To: <20121030115223.18780.29992@nucleus>
References: <1349125926-16144-1-git-send-email-gregory.clement@free-electrons.com>
 <1349125926-16144-4-git-send-email-gregory.clement@free-electrons.com>
 <20121030115223.18780.29992@nucleus>
Message-ID: <50A2981C.4030705@us.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2012 04:52 AM, Mike Turquette wrote:
> Quoting Gregory CLEMENT (2012-10-01 14:12:06)
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> I'm not sure this patch should go through me.  Perhaps John Stultz?

I can apply it to my tree, but really none of it is generic, so in the 
future I'd almost rather someone who could reasonably audit the changes 
for correctness merge it instead (although I always appreciate being 
Cc'ed into the loop).

thanks
-john

From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 Jan 2014 14:52:56 -0800
Subject: [GIT PULL] Xilinx Zynq dt fixes for v3.14
In-Reply-To: <52EA7976.7030709@monstr.eu>
References: <52EA7976.7030709@monstr.eu>
Message-ID: <20140131225256.GB6284@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 30, 2014 at 05:10:30PM +0100, Michal Simek wrote:
> Hi guys,
> 
> please consider to queue this patch to 3.14 because it enables Arasan
> SDHCI driver which has been merged to the tree. It took for a while
> to get it to the mainline that's why I didn't push this patch
> in regular arm-soc merge window. I was talking about it
> with Kevin some weeks ago.
> 
> There will be one more patch which I have discussed with Russell but
> I will send it out for reviewed first.
> https://lkml.org/lkml/2014/1/27/212

I ended up cherry-picking the patch instead, since your base is different from
what we have today. But the patch has been applied to our fixes branch now and
will be sent up.


-Olof

From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 17 Apr 2013 16:00:57 +0400
Subject: [PATCH] ARM: shmobile: BOCK-W: enable CONFIG_PM_RUNTIME in
 defconfig
In-Reply-To: <20130417101017.GW14496@n2100.arm.linux.org.uk>
References: <201304170303.46193.sergei.shtylyov@cogentembedded.com>
 <20130417101017.GW14496@n2100.arm.linux.org.uk>
Message-ID: <516E8EF9.8030600@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 17-04-2013 14:10, Russell King - ARM Linux wrote:

>> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

>> Enable CONFIG_PM_RUNTIME in 'bockw_defconfig' -- it's already used by TMU, SCI,
>> I2C, and Ether drivers to control the clocks...

>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>> The patch is atop of Simon's 'renesas.git' tree, 'renesas-next-20130416' tag.

> Maybe you should send it to Simon rather than me for initial merging, who
> would presumably know if this is the right thing for this bockw platform?

    Blame scripts/get_maintainer.pl.
    I think Simion will see the patch on the list anyway.

WBR, Sergei

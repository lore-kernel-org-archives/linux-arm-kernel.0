From: joel@jms.id.au (Joel Stanley)
Date: Thu, 19 Jan 2017 13:59:51 +1100
Subject: [GIT PULL] ARM: aspeed: devicetree for 4.11
In-Reply-To: <20170119002711.GJ23725@localhost>
References: <CACPK8XffqYCRipx+KzxyH0z-5=t53ezPjRv+MxOj7-tj2kbG2A@mail.gmail.com>
 <20170119002711.GJ23725@localhost>
Message-ID: <CACPK8Xds110=xAxXqb=pK3vufA_mm1ntrrtJ2EOvbFBqd0V+eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 11:27 AM, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Jan 18, 2017 at 09:50:02AM +1100, Joel Stanley wrote:

>> These commits also add newly upstreamed drivers to the Palmetto BMC and ast2500
>> eval board. We now have working network, ipmi bt, gpio and pinmux on
>> all platforms.
>>
>>   ARM: dts: aspeed: Add Romulus BMC platform
>>   ARM: dts: aspeed: Add ftgmac100 to g4 and g5 platforms
>>   ARM: dts: aspeed: Correct palmetto device tree
>>   ARM: dts: aspeed: Reserve framebuffer memory
>>   ARM: dts: aspeed-g5: Add gpio controller to devicetree
>>   ARM: dts: aspeed-g5: Add syscon and pin controller nodes
>>   ARM: dts: aspeed-g5: Add LPC Controller node
>>   ARM: dts: aspeed-g5: Add SoC Display Controller node
>>   ARM: dts: aspeed-g4: Add gpio controller to devicetree
>>   ARM: dts: aspeed-g4: Add syscon and pin controller nodes
>
> Hi,
>
> Merged, but for the future there's no need for you to list the patches in the
> tag message, git inserts a list when we merge (--log), and git request-pull
> already provides the shortlog.

Thanks for the heads up. I've made a note of that for next time.

> (512MB RAM on a BMC? That's just insane :).

Yep :) It was 1GB in the first spin of the board.

Cheers,

Joel

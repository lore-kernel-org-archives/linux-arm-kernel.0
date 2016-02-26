From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 26 Feb 2016 12:53:38 -0700
Subject: [PATCH v2] ARM: dts: tegra: correct Beaver pinmux
In-Reply-To: <1456515384.20487.2.camel@lynxeye.de>
References: <1456514310-27605-1-git-send-email-dev@lynxeye.de>
 <56D0A748.6060104@wwwdotorg.org> <1456515384.20487.2.camel@lynxeye.de>
Message-ID: <56D0AD42.9050507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2016 12:36 PM, Lucas Stach wrote:
> Am Freitag, den 26.02.2016, 12:28 -0700 schrieb Stephen Warren:
>> On 02/26/2016 12:18 PM, Lucas Stach wrote:
>>> Update pinmux to get rid of invalid uses of the rsvd1 function,
>>> which lead
>>> to the mux settings on those pins to not be applied.
>>>
>>> Also add correct drive settings, derived from the Tegra3 TRM, for
 >
> Your comment from v1 is addressed here  ^^^^^^^^^^^^^^^^^^^^^^^^

Oh right, sorry about that.

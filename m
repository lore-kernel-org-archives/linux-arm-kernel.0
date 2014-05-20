From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 20 May 2014 09:40:39 -0400
Subject: [GIT PULL 1/2] ARM: Keystone SOC updates for 3.16
In-Reply-To: <20140520051507.GJ18956@quad.lixom.net>
References: <1399912877-29595-1-git-send-email-santosh.shilimkar@ti.com>
 <20140520051507.GJ18956@quad.lixom.net>
Message-ID: <537B5B57.2050202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 May 2014 01:15 AM, Olof Johansson wrote:
> On Mon, May 12, 2014 at 12:41:17PM -0400, Santosh Shilimkar wrote:
>> Hi Arm-soc folks,
>>
>> Please pull below keystone SOC updates for 3.16. It merges cleanly with
>> arm-soc 'next/soc' head. As already discussed, the $subject pull request
>> has a depedency with DT dma-properties pull request [1] I sent last week
>> to be pulled into arm-soc.
> 
> Hi,
> 
> I didn't see a reply from Russell on that pull request yet, so I haven't
> brought it in as a dependency in case he has comments and it needs to be
> respun.
> 
I pinged RMK to pull the series. After that you can pull the dependent
pull request as well as subject series. Just for wider testing purpose,
I have included the dma series in my next branch and it sitting in
linux-next for more than 2 weeks now.

> If this branch is dependent on that code, then you really need to base it on
> top of it, or else you will break bisectability. Essentially you might end up
> in a state with bisect where only these patches are applied and not the
> dependent ones.
> 
I thought about that. The git objects as they exist now in pull request will
ensure that the $subject series patches appears after the dependent series.
I wanted to avoid SOC stuff to be mixed with the dma series. 

Regards,
Santosh

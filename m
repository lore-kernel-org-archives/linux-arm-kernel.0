From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Dec 2012 11:22:13 -0800
Subject: [PATCH V3] ARM: bcm281xx: Add timer driver
In-Reply-To: <50C785DD.8030407@broadcom.com>
References: <1355250387-622-1-git-send-email-csd@broadcom.com>
 <50C78330.7040605@wwwdotorg.org> <50C785DD.8030407@broadcom.com>
Message-ID: <CAOesGMiwLnYVqOTRpc6ij_eMnoFxGM2W1VBS__PrD+_z51P6dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 11:13 AM, Christian Daudt <csd@broadcom.com> wrote:
> On 12-12-11 11:02 AM, Stephen Warren wrote:
>>
>> On 12/11/2012 11:26 AM, Christian Daudt wrote:
>>>
>>> This adds support for the Broadcom timer, used in the following SoCs:
>>> BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
>>
>> Reviewed-by: Stephen Warren<swarren@nvidia.com>
>>
> Thanks.
>
>
>>> This patch needs the arm-soc/soc/next branch
>>
>> Only if it goes into 3.8, which I assume it won't?
>>
> Ok, I wasn't clear on that. I meant that this patch only applies on top of
> arm-soc/soc/next as it needs the mach-bcm patch which is sitting only there
> at the moment. I'm fine with having this in 3.8 as this patch only affects
> the above SoCs. But I'll leave that to Olof and Arnd.

Let's aim for 3.9 at this time. Once we've merged all our stuff for
3.8, if there is time left, I might revisit this but by default 3.9 is
the appropriate target right now.



-Olof

From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 25 Feb 2014 19:20:46 +0530
Subject: [PATCH RESEND v10 1/4] PHY: Add function set_speed to generic
 PHY framework
In-Reply-To: <20140225134517.GA26189@htj.dyndns.org>
References: <1393308882-3964-1-git-send-email-lho@apm.com>
 <1393308882-3964-2-git-send-email-lho@apm.com> <530C8711.4000600@ti.com>
 <20140225134517.GA26189@htj.dyndns.org>
Message-ID: <530C9FB6.9070600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 February 2014 07:15 PM, Tejun Heo wrote:
> On Tue, Feb 25, 2014 at 05:35:37PM +0530, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Tuesday 25 February 2014 11:44 AM, Loc Ho wrote:
>>> This patch adds function set_speed to the generic PHY framework operation
>>> structure. This function can be called to instruct the PHY underlying layer
>>> at specified lane to configure for specified speed in hertz.
>>>
>>> Signed-off-by: Loc Ho <lho@apm.com>
>>> ---
>>>  drivers/phy/phy-core.c  |   21 +++++++++++++++++++++
>>>  include/linux/phy/phy.h |    8 ++++++++
>>>  2 files changed, 29 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>>> index 645c867..44f2f63 100644
>>> --- a/drivers/phy/phy-core.c
>>> +++ b/drivers/phy/phy-core.c
>>> @@ -257,6 +257,27 @@ int phy_power_off(struct phy *phy)
>>>  }
>>>  EXPORT_SYMBOL_GPL(phy_power_off);
>>>  
>>
>> missing function comment :-s
> 
> Can you please let me know when this series goes in?  I'll pull in the
> phy tree into libata and then apply the ata patches on top.

I'll send the final pull request for 3.15 merge window by next weekend to Greg
kh. Before that I'd like to have my comments addressed in this patch series.

Thanks
Kishon

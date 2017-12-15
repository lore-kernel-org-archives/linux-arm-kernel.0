From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 15 Dec 2017 17:20:32 +0900
Subject: [PATCH v2 1/5] extcon: usbc-cros-ec: add support to notify USB
 type cables.
In-Reply-To: <20171215081453.6jwjdetwe655imqo@dell>
References: <CGME20171213103241epcas2p412031074459fa3893388ffca4f894abc@epcas2p4.samsung.com>
 <20171213103219.1464-1-enric.balletbo@collabora.com>
 <5A33702D.60004@samsung.com> <20171215081453.6jwjdetwe655imqo@dell>
Message-ID: <5A3385D0.2050308@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017? 12? 15? 17:14, Lee Jones wrote:
>> On 2017? 12? 13? 19:32, Enric Balletbo i Serra wrote:
>>> From: Benson Leung <bleung@chromium.org>
>>>
>>> Extend the driver to notify host and device type cables and the presence
>>> of power.
>>>
>>> Signed-off-by: Benson Leung <bleung@chromium.org>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>> Changes since v1:
>>>  - Use the BIT macro. Requested by Lee Jones.
>>>  - Add the Reviewed-by: Chanwoo Choi.
>>>
>>>  drivers/extcon/extcon-usbc-cros-ec.c | 142 ++++++++++++++++++++++++++++++++++-
>>>  include/linux/mfd/cros_ec_commands.h |  17 +++++
>>>  2 files changed, 155 insertions(+), 4 deletions(-)
> 
>> Looks good to me. After reviewing the Lee Jones,
>> I'll take it on next branch.
> 
> If you take it, you need to send me a pull-request to an immutable
> branch.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 

Sure. I'll send the immutable branch. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

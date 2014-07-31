From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 01 Aug 2014 03:35:38 +0900
Subject: [PATCHv9 1/5] mmc: dw_mmc: Slot quirk "disable-wp" is deprecated.
In-Reply-To: <CAD=FV=VfXOqt1A=8-1kq5nhnMrk7PbpCWj-A-UWQN12_U8sW4g@mail.gmail.com>
References: <1406784907-26349-1-git-send-email-jh80.chung@samsung.com>	<1406784907-26349-2-git-send-email-jh80.chung@samsung.com>
 <CAD=FV=VfXOqt1A=8-1kq5nhnMrk7PbpCWj-A-UWQN12_U8sW4g@mail.gmail.com>
Message-ID: <53DA8C7A.60205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/14 01:02, Doug Anderson wrote:
> Jaehoon
>
> On Wed, Jul 30, 2014 at 10:35 PM, Jaehoon Chung<jh80.chung@samsung.com>  wrote:
>> Slot quirks "disable-wp" is deprecated.
>> Instead, use the host quirk "disable-wp".
>> (Because the slot-node is removed in dt-file.)
>>
>> Signed-off-by: Jaehoon Chung<jh80.chung@samsung.com>
>> Tested-by: Sachin Kamat<sachin.kamat@samsung.com>
>> Acked-by: Seungwon Jeon<tgih.jun@samsung.com>
>> ---
>>   drivers/mmc/host/dw_mmc.c  |   11 +++++++++--
>>   include/linux/mmc/dw_mmc.h |    2 ++
>>   2 files changed, 11 insertions(+), 2 deletions(-)
>
> Thanks for taking my suggestion and making it backward compatible.
> This looks great to me.  It tested this in both the backward
> compatible way (with the warning) and the non-backward compatible way.
> I think we should land and patch #2 ASAP and then we can land the rest
> of the series as SoC maintainers see fit.
>
Yes, right if we don't want to see useless merge conflicts...

- Kukjin

> Reviewed-by: Doug Anderson<dianders@chromium.org>
> Tested-by: Doug Anderson<dianders@chromium.org>

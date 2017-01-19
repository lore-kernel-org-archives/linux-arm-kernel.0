From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 19 Jan 2017 13:55:57 +0000
Subject: [PATCH] coresight: STM: Balance enable/disable
In-Reply-To: <20170119114037.GR28024@kroah.com>
References: <1484589600-21397-1-git-send-email-suzuki.poulose@arm.com>
 <20170119114037.GR28024@kroah.com>
Message-ID: <d98d0fb3-4271-ed5f-893f-e342bf0776ca@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/17 11:40, Greg KH wrote:
>> Fixes: commit 237483aa5cf43 ("coresight: stm: adding driver for CoreSight STM component")
>> Cc: Pratik Patel <pratikp@codeaurora.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: stable at vger.kernel.org # 4.7+
>> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Reviewed-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>> Reported-by: Robert Walker <robert.walker@arm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>
>> Greg,
>>
>> Without this patch, the coresight STM IP can only be used for one tracing
>> session per boot, seriously limiting its usability.
>
> When you resend a patch, please tell me what is different from the
> previous version you sent.  I figured it out here, but please do this
> next time.

Hi Greg,

Sure, will keep that in mind. For this patch nothing has changed, except for
the addition of Review/Ack. It was resent (with to: you) just to make sure it
gets through the rc series. Thanks for queuing it.

Suzuki

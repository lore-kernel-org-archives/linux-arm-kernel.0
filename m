From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 12 Jul 2016 11:08:37 -0400
Subject: [PATCH] media: s5p-mfc Fix misspelled error message and
 checkpatch errors
In-Reply-To: <578507B2.9020501@osg.samsung.com>
References: <1468276740-1591-1-git-send-email-shuahkh@osg.samsung.com>
 <8dd68d9b-9455-d593-dc0f-c269c778b961@osg.samsung.com>
 <578507B2.9020501@osg.samsung.com>
Message-ID: <e6254aaa-68d5-72d9-a226-863db8632662@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shuah,

On 07/12/2016 11:07 AM, Shuah Khan wrote:
> On 07/12/2016 09:03 AM, Javier Martinez Canillas wrote:
>> Hello Shuah,
>>
>> On 07/11/2016 06:39 PM, Shuah Khan wrote:
>>> Fix misspelled error message and existing checkpatch errors in the
>>> error message conditional.
>>>
>>> WARNING: suspect code indent for conditional statements (8, 24)
>>>  	if (ctx->state != MFCINST_HEAD_PARSED &&
>>> [...]
>>> +               mfc_err("Can not get crop information\n");
>>>
>>> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
>>> ---
>>
>> Patch looks good to me. Maybe is better to split the message and checkpatch
>> changes in two different patches. But I don't have a strong opinion on this:
>>
>> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
> 
> Thanks for the review. I considered splitting them, however the patch
> that fixes the message will be flagged by checkpatch. It does make
> sense to split the changes into two patches. What I could do is, make
> the checkpatch fixes the first patch and fix the error message in the
> second one.
> 
> How does that sound?
>

Sounds good to me.
 
> -- Shuah
> 
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America

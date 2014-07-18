From: josh.wu@atmel.com (Josh Wu)
Date: Fri, 18 Jul 2014 11:15:45 +0800
Subject: [PATCH v2 3/3] [media] atmel-isi: add primary DT support
In-Reply-To: <2360323.ktzTJnrmOX@avalon>
References: <1395744087-5753-1-git-send-email-josh.wu@atmel.com>
 <Pine.LNX.4.64.1403302313290.12008@axis700.grange>
 <53392FC9.9070706@atmel.com> <2360323.ktzTJnrmOX@avalon>
Message-ID: <53C89161.4080405@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Laurent

On 7/17/2014 7:00 PM, Laurent Pinchart wrote:
> Hi Josh,
>
> What's the status of this patch set ? Do you plan to rebase and resubmit it ?

Thanks for the reminding.
yes,  I will rebase it and resubmit the new version for this patch set 
with the data bus width support.
Thanks.

Best Regards,
Josh Wu
>
> On Monday 31 March 2014 17:05:13 Josh Wu wrote:
>> Dear Guennadi
>>
>> On 3/31/2014 5:20 AM, Guennadi Liakhovetski wrote:
>>> Hi Josh,
>>>
>>> Please correct me if I'm wrong, but I don't see how this is going to work
>>> without the central part - building asynchronous V4L2 data structures from
>>> the DT, something that your earlier patch
>> Here you mean Bryan Wu not me, right?   ;-)
>> Bryan write the patch "[v2] media: soc-camera: OF cameras" in:
>> https://patchwork.linuxtv.org/patch/22288/.
>> And I saw Ben Dooks already sent out his patch to support soc-camera OF
>> now (https://patchwork.linuxtv.org/patch/23304/) which is simpler than
>> Bryan's.
>>
>>> "media: soc-camera: OF cameras"
>>> was doing, but which you stopped developing after a discussion with Ben
>>> (added to Cc).
>> And yes, atmel-isi dt patch should not work without above SoC-Camera of
>> support patch.
>> But as the atmel-isi dt binding document and port node can be finalized.
>> So I think this patch is ready for the mainline.
>>
>> BTW: I will test Ben's patch with atmel-isi.

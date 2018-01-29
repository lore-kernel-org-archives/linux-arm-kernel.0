From: ssuloev@orpaltech.com (Sergey Suloev)
Date: Mon, 29 Jan 2018 16:20:17 +0300
Subject: unplug/plug HDMI in runtime on boards using sun4i DRM
In-Reply-To: <0b0eafa7-4377-6b09-c5e6-e9846772bceb@orpaltech.com>
References: <fed0ce4c-c231-1f85-ec31-5c79da5a4c28@orpaltech.com>
 <20180129131136.awbsicwi5u553cjc@flea.lan>
 <0b0eafa7-4377-6b09-c5e6-e9846772bceb@orpaltech.com>
Message-ID: <ac1f988b-b536-40b6-d167-905867c8c28c@orpaltech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2018 04:19 PM, Sergey Suloev wrote:
> On 01/29/2018 04:11 PM, Maxime Ripard wrote:
>> On Mon, Jan 29, 2018 at 01:53:45PM +0300, Sergey Suloev wrote:
>>> Hi Maxime
>>>
>>> is the patch below supposed to fix the issue with a oops during 
>>> unplug/plug
>>> HDMI in runtime on boards using sun4i DRM?
>>>
>>> http://code.bulix.org/yhjegn-240878?raw
>> I haven't heard any news from anyone with regard to whether it was
>> fixing their issue or not, so I don't know.
>>
>> Maxime
>>
> I haven't heard any news from anyone with regard to whether it was
> fixing their issue or not, so I don't know.
>
> Thanks
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

I've been told that it would fix? the oops mentioned above. I tried to 
apply it? on 4.15 and it didn't work. That's why I am asking if it 
should or may be it was aimed to something else.

Thanks

From: yad.naveen@gmail.com (naveen yadav)
Date: Thu, 25 Aug 2011 12:08:12 +0530
Subject: Kernel panic in 2.6.35.12 kernel
In-Reply-To: <CAJ8eaTw=dKUNE8h-HD7RWxXHcTEuxJH4AfcOO44RSF7QdC5arQ@mail.gmail.com>
References: <CAJ8eaTyeQj5_EAsCFDMmDs3faiVptuccmq3VJLjG-QnYG038=A@mail.gmail.com>
	<CAJ8eaTw=dKUNE8h-HD7RWxXHcTEuxJH4AfcOO44RSF7QdC5arQ@mail.gmail.com>
Message-ID: <CAJ8eaTyaiFzAnKB-P9EJT5UxxmpgTpw=Yk_Ee8qJUVKFjfHtKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

adding to mm mailing list

On Thu, Aug 25, 2011 at 11:36 AM, naveen yadav <yad.naveen@gmail.com> wrote:
> I am paste only small crash log due to size problem.
>
>
>
>
>> Hi All,
>>
>> We are running one malloc testprogram using below script.
>>
>> while true
>> do
>> ./stress &
>> sleep 1
>> done
>>
>>
>>
>>
>> After 10-15 min we observe following crash in kernel
>>
>>
>> ?Kernel panic - not syncing: Out of memory and no killable processes...
>>
>> attaching log also.
>>
>> Thanks
>>
>

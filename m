From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 25 May 2010 08:30:28 -0700
Subject: [PATCH 3/6] davinci: edma: clear events in edma_start()
In-Reply-To: <4BFBA100.4020805@windriver.com> (stanley miao's message of "Tue\,
	25 May 2010 18\:05\:52 +0800")
References: <1268841163-5868-1-git-send-email-khilman@deeprootsystems.com>
	<1268841163-5868-4-git-send-email-khilman@deeprootsystems.com>
	<4BFA6A22.1000006@windriver.com> <871vd16wic.fsf@deeprootsystems.com>
	<4BFBA100.4020805@windriver.com>
Message-ID: <87fx1gov6z.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"stanley.miao" <stanley.miao@windriver.com> writes:

> Kevin Hilman wrote:
>> <snip>
>>>>
>>>>       
>>> This patch causes that the sound can not work normally on OMAP_L138.
>>>
>>>     
>>
>> Can you describe "can not work normally"?  Does that mean simply does
>> not work, or works with pops & clicks etc.?
>>
>> Just to clarify... how did you isolate it to this patch.
>>
>> If you revert just this patch on current davinci git, do you have
>> working sound as you expect again?
>>   
> Below is the test result:
>
> $/root> aplay audiodump.wav
> Playing WAVE 'audiodump.wav' : Signed 16 bit Little Endian, Rate 44100
> Hz, Stereo
> aplay: pcm_write:1269: write error: Input/output error
> $/root>
>
> After revert it, the audio works fine.

Thanks for clarifying.

Kevin

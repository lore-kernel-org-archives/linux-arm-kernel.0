From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 10 May 2018 19:43:03 +0300
Subject: [PATCH] arm64: dts: renesas: r8a77970: add SMP support
In-Reply-To: <20180509190517.ho5og3grbuzf4wz4@verge.net.au>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
 <54dbd1d2-8279-5073-cffb-c647fba91e42@cogentembedded.com>
 <CAMuHMdUqVVWz0jLb2Vmrkk3BQBsYVsCOW1zsaPUi8o6jr_mojQ@mail.gmail.com>
 <db136ee6-4ce6-756e-743d-3342b2e65f2b@cogentembedded.com>
 <20180509190517.ho5og3grbuzf4wz4@verge.net.au>
Message-ID: <110ba99c-1a8d-98a1-3ca0-5fc99e79572b@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 05/09/2018 10:05 PM, Simon Horman wrote:

>>>> Add the device node for the second Cortex-A53 CPU core.
>>>>
>>>> Based on the original (and large) patch by Daisuke Matsushita
>>>> <daisuke.matsushita.ns@hitachi.com>.
>>>>
>>>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>
>>> Dupe of https://patchwork.kernel.org/patch/10032875/
>>
>>    Sorry!
>>    Not an exact dupe, though -- mine has clock/power #define's used,
>> yours -- only bare #s. :-)
>>
>>> From series "[PATCH 0/2] arm64: dts: renesas: r8a77970: Add SMP Support"
>>> (https://www.spinics.net/lists/linux-renesas-soc/msg19681.html)
>>
>>    Hmm... what's the fate of this series?
> 
> There is now a v2 of Geert's series which incorporates your enhancements.

   I suggested to respin it. :-)

> I will apply that.

   Thank you.
   For the record, I had better luck than Geert testing SMP on Eagle: only CPU0
couldn't be offlined (and I was unable to find a workaround), others could be on/
offlined w/o issues. As for suspend/resume -- it did work but I could only test
s2idle (/sys/power/mem_sleep had no other variants)...

MBR, Sergei

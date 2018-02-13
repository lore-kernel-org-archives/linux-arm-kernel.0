From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 13 Feb 2018 13:46:58 +0300
Subject: [PATCH 0/3] Add R8A77970/Eagle PFC support
In-Reply-To: <20180213075222.mf7dsbwgv5ln4ond@verge.net.au>
References: <20171110200218.747996672@cogentembedded.com>
 <20171113075303.zmkmq6bt3lfuttwu@verge.net.au>
 <049b0a0a-b1c2-73e6-c471-ca8342bba6ab@ideasonboard.com>
 <19d23fa2-1205-89a0-786f-f301ca7a0f7b@cogentembedded.com>
 <20180213075222.mf7dsbwgv5ln4ond@verge.net.au>
Message-ID: <b6f69e47-1bce-1939-9315-0364c6397a85@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2018 10:52 AM, Simon Horman wrote:

>>>>> Here's the set of 3 patches against Simon Horman's 'renesas.git' repo's
>>>>> 'renesas-devel-20171110-v4.14-rc8' tag.  We're adding the R8A77970 PFC node
>>>>> and then describing the pins for SCIF0 and EtherAVB devices declared earlier.
>>>>> These patches depend on the R8A77970 PFC suport in order to work properly.
>>>>>
>>>>> [1/3] arm64: dts: renesas: r8a77970: add PFC support
>>>>> [2/3] arm64: dts: renesas: eagle: add SCIF0 pins
>>>>> [3/3] arm64: dts: renesas: eagle: add EtherAVB pins
>>>>
>>>> Hi Sergei,
>>>>
>>>> I have marked these patches as deferred pending acceptance of the PFC
>>>> driver. Please repost or otherwise ping me once that dependency has been
>>>> accepted.
>>>
>>> Has the dependency blocking this series been resolved yet ?
>>
>>    Now it is, except for the 3rd patch... Simon, do I need to repost the first two?
>> The 1st one did apply to 4.16-rc1 here with a fuzz...
> 
> Thanks for bringing this to my attention.  No need to repost. I've applied
> all three patches and plan to push later today.

   My mentioning of the patch #3 wasn't just random: that patch shouldn't have been
merged since the EtherAVB pin groups were dropped by Geert while merging the R8A77970
PFC code. Now Eagle can't mount NFS root.

MBR, Sergei

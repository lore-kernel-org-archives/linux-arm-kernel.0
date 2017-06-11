From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Sun, 11 Jun 2017 23:05:02 +0300
Subject: [PATCH v8 00/34] i.MX Media Driver
In-Reply-To: <e4f152de-6e75-7654-178e-e6dcf9ad12f3@xs4all.nl>
References: <1496860453-6282-1-git-send-email-steve_longerbeam@mentor.com>
 <e7e4669c-2963-b9e1-edd7-02731a6e0f9c@xs4all.nl>
 <c0b69c93-b9cd-25e8-ea36-fc0600efdb69@gmail.com>
 <e4f152de-6e75-7654-178e-e6dcf9ad12f3@xs4all.nl>
Message-ID: <43887f25-bb73-9020-0909-d275c319aaad@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2017 02:26 AM, Hans Verkuil wrote:
> On 10/06/17 01:16, Steve Longerbeam wrote:
>>
>>
>> On 06/07/2017 12:02 PM, Hans Verkuil wrote:
>>> We're still waiting for an Ack for patch 02/34, right?
>>>
>>
>> Hi Hans, Rub has provided an Ack for patch 2.
>>
>>> Other than that everything is ready AFAICT.
>>>
>>
>> But as Pavel pointed out, in fact we are missing many
>> Acks still, for all of the dts source changes (patches
>> 4-14), as well as really everything else (imx-media staging
>> driver patches).
> 
> No Acks needed for the staging part. It's staging, so not held
> to the same standards as non-staging parts. That doesn't mean
> Acks aren't welcome, of course.

Acks are wanted for particular i.MX DTS changes including device
tree binding descriptions.

Shawn, please bless the series.

> 
> You don't need Greg's Ack for staging/media either, patches there
> go in via us (generally at least) and we handle those, not Greg.
> 

--
With best wishes,
Vladimir

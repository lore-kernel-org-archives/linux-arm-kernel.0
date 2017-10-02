From: wni@nvidia.com (Wei Ni)
Date: Mon, 2 Oct 2017 06:03:04 -0700
Subject: [PATCH v2 5/5] thermal: Add Tegra BPMP thermal sensor driver
In-Reply-To: <20170830193252.GA12761@ulmo>
References: <20170724162918.21050-1-mperttunen@nvidia.com>
 <20170724162918.21050-5-mperttunen@nvidia.com>
 <1502420276.2598.5.camel@intel.com>
 <4315091f-03b1-2df6-b224-6a29d3261371@nvidia.com>
 <20170830193252.GA12761@ulmo>
Message-ID: <e7999b0d-0de6-6f92-7d8c-008842b75d75@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/30/2017 12:32 PM, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Mon, Aug 21, 2017 at 10:40:44AM +0800, Wei Ni wrote:
>>
>>
>> On Friday, August 11, 2017 10:57 AM, Zhang Rui wrote:
>>> On Mon, 2017-07-24 at 19:29 +0300, Mikko Perttunen wrote:
>>>> On Tegra186, the BPMP (Boot and Power Management Processor) exposes
>>>> an
>>>> interface to thermal sensors on the system-on-chip. This driver
>>>> implements access to the interface. It supports reading the
>>>> temperature, setting trip points and receiving notification of a
>>>> tripped trip point.
>>>>
>>>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>>>
>>> Wei Ni,
>>>
>>> what do you think of this patch?
>>
>> Reviewed this patch, it looked fine to me.
> 
> Can I take this as a Reviewed-by?

Hi Thierry,
Sorry for late response.
Yes I think you can take this as Reviewed-by.

BTW, although I have reviewed this serial patches, actually I haven't
been work on thermal drivers for a long time, I think Mikko is good on
thermal upstream issues ?

Thanks.
Wei.
> 
> Thierry
> 
> * Unknown Key
> * 0x7F3EB3A1
> 

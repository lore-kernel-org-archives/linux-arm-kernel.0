From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 28 Feb 2018 16:32:37 +0000
Subject: [PATCH 00/12] firmware: arm_scpi: series with smaller improvements
In-Reply-To: <7hbmhpybbw.fsf@baylibre.com>
References: <99220c79-8b35-2978-11d1-6d101ccb6772@gmail.com>
 <db85dc34-5755-c48d-8a23-379d95fc0342@arm.com> <7hbmhpybbw.fsf@baylibre.com>
Message-ID: <e931fc0b-301d-b4cb-96e4-a34b84648170@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/01/18 18:04, Kevin Hilman wrote:
> Sudeep Holla <sudeep.holla@arm.com> writes:
> 
>> Hi Heiner,
>>
>> (Sorry for the late response, was off for a month)
>>
>> On 05/12/17 21:54, Heiner Kallweit wrote:
>>> After recent revert of all changes since 4.14 this is a resubmit of
>>> the patch series, reduced to patches which should not cause any
>>> regression.
>>> Based on a remark from Kevin I added one patch for improving the
>>> version info for pre-1.0 firmware that doesn't provide version
>>> information.
>>>
>>> Best should be to apply it to a devel branch first so that the
>>> Baylibre Amlogic team can test before mainlining.
>>>
>>
>> I am still waiting for tested by from Amlogic team for this series.
> 
> I (finally) tested this series on a few of the boards that were failing
> last time, and those issues are gone.
> 
> So, for the series...
> 
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> 

Thanks, pulled the series[1] with Kevin's tested-by now.

-- 
Regards,
Sudeep

[1] https://git.kernel.org/sudeep.holla/linux/h/for-next/scpi

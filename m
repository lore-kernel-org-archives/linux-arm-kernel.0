From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 20 May 2013 11:12:22 +0530
Subject: [PATCH v3 0/6] ARM: OMAP2+: hwmod and SERIAL: Remove sysc handling
 from driver
In-Reply-To: <87txm1smrz.fsf@linaro.org>
References: <1368629322-3170-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1305161831390.21357@utopia.booyaka.com>
 <87txm1smrz.fsf@linaro.org>
Message-ID: <5199B7BE.8060808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 17 May 2013 07:59 PM, Kevin Hilman wrote:
> Hi Paul,
> 
> Paul Walmsley <paul@pwsan.com> writes:
> 
>> On Wed, 15 May 2013, Rajendra Nayak wrote:
>>
>>> OMAP UART IP needs manual idle modes based on functional state of the
>>> IP. Currently this is handled by the driver with function pointers
>>> implemented in platform code.
>>>
>>> This however breaks in case of device tree because of missing
>>> idle handling. 
>>>
>>> The series tries to address the issue and tries to remove complete
>>> sysc handling from serial driver.
>>
>> These look good to me.  Will queue them for v3.10-rc once they pass local 
>> testing here.
> 
> I reviewed and tested v2 of this (Rajendra forgot to add the tags in

Oops, sorry about that Kevin, and thanks for the repeated reviews and
tests on this series.

regards,
Rajendra

> v3) and also just sanity tested v3 of this on 4430/panda DT boot to
> verify the console issue is resolved.  Feel free to add:
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> Tested-by: Kevin Hilman <khilman@linaro.org>  # OMAP4/Panda
> 
> Kevin
> 

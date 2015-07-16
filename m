From: danindrey@mail.ru (Andrey Danin)
Date: Thu, 16 Jul 2015 12:03:43 +0300
Subject: How to encode being an I2C slave in DT?
In-Reply-To: <20150519061619.GA4448@schokonusskuchen.bad>
References: <1427745615-5428-1-git-send-email-danindrey@mail.ru>
 <20150403194635.GC2016@katana> <1549160.njMIY2NVTi@fb07-iapwap2>
 <20150505105513.GA1841@katana> <554922EF.3050906@wwwdotorg.org>
 <20150506161712.GA4003@katana>
 <CAL_Jsq+iyeK-bV3ggcJv8Cw3EU71fkBo1wqYZnhCoh2-b_tO-Q@mail.gmail.com>
 <20150519061619.GA4448@schokonusskuchen.bad>
Message-ID: <55A7736F.5090802@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wolfram,

On 19.05.2015 9:16, Wolfram Sang wrote:
>
>>> I give in to the flag idea. I also noticed that we'd need another flag
>>> anyhow to mark 10 bit addresses. I am still thinking between using two
>>> address-cells in that case (clean seperation between address and flags)
>>> or to encode the flags as MSB in the current address (all busses will
>>> have same address-cells and child description, less code paths and no
>>> overhead in dtbs).
>>
>> Reading thru the thread, this seems good to me. I would go with adding
>> flags in the MSB of the reg cell rather than adding a cell.
>
> Thanks. I was leaning to the MSB idea, too, and am currently checking
> how the code would look like. Feels much better to do knowing that it is
> basically upstream compatible ;)
>
Did you have enough time to check this ?
(sorry for the noise, if I missed patch(es) in the ml)

Thanks.

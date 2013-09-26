From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 26 Sep 2013 14:21:52 +0200
Subject: [PATCH v2 00/12] clk/exynos convert clock IDs to macros
In-Reply-To: <20130916193709.27384.86101@quantum>
References: <1378462361-13680-1-git-send-email-a.hajda@samsung.com>
 <8412301.YP2zzplWoe@amdc1227>
 <070001ceafa5$d4d81a40$7e884ec0$%kim@samsung.com>
 <523716C9.3000204@samsung.com> <20130916193709.27384.86101@quantum>
Message-ID: <524426E0.7020006@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16/2013 09:37 PM, Mike Turquette wrote:
> Quoting Sylwester Nawrocki (2013-09-16 07:33:45)
>> On 09/12/2013 12:50 PM, Kukjin Kim wrote:
>>> Well...I'm not sure changing to use macro is better or not at this moment...
>> I think it is. ;) It's really less error prone to have symbolic names instead
>> of the plain numbers. The clock ids are defined in one place and it is more
>> clear what a clock is by looking at symbolic name. It's especially annoying 
>> to use plain numbers where are are many clock in a single node, like 10 or 
>> more. What are you main concerns with this ?
> I think having the symbolic names is a win for readability.
>
> Regards,
> Mike
>
>> --
>> Regards,
>> Sylwester
Hi Kukjin,

Any thoughts/decisions regarding this patchset ?

Regards
Andrzej

From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 3 Dec 2010 14:52:23 +0900
Subject: [PATCH 2/4] mach-s5pv310: Add resource definitions for mipi-csis
In-Reply-To: <AANLkTiksQM8V9QeF+P2qvCQ1uOgcq-yzKp-kgnPVmMsJ@mail.gmail.com>
References: <1291307862-8125-1-git-send-email-s.nawrocki@samsung.com>
	<1291307862-8125-3-git-send-email-s.nawrocki@samsung.com>
	<012401cb92a3$a46443b0$ed2ccb10$%kim@samsung.com>
	<AANLkTimEEf5eD+q-qx7gw21ryFp1bbQ084Lo=eX+Bqjz@mail.gmail.com>
	<AANLkTiksQM8V9QeF+P2qvCQ1uOgcq-yzKp-kgnPVmMsJ@mail.gmail.com>
Message-ID: <AANLkTikjXjS3AwuaYdRSr7Gs7jR3Yg8_vK4vrS62syDT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 3, 2010 at 2:34 PM, Kyungmin Park <kyungmin.park@samsung.com> wrote:
> On Fri, Dec 3, 2010 at 1:59 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>>> Sylwester Nawrocki wrote:

>>> +#define S5PV310_PA_CSIS0 ? ? ? ? ? ? (0x11880000)
>>> +#define S5PV310_PA_CSIS1 ? ? ? ? ? ? (0x11890000)
>>
>> Let us please not contain constants in brackets.
>
> I think consistency is more higher than your comment normally.
>
> if you think these, then make a cleanup first.

Bad logic. One shouldn't hold good practice at ransom because of
the past bad ones.

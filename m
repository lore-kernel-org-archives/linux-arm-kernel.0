From: davem@davemloft.net (David Miller)
Date: Mon, 24 Jul 2017 13:41:44 -0700 (PDT)
Subject: [PATCH] net: Convert to using %pOF instead of full_name
In-Reply-To: <CAL_JsqJbEq0_yQ-T8-SGTQbRRxHs-MMCuBrK6d8_2jGQ_-7QkA@mail.gmail.com>
References: <20170718214339.7774-39-robh@kernel.org>
 <20170718.145146.1983238254018568174.davem@davemloft.net>
 <CAL_JsqJbEq0_yQ-T8-SGTQbRRxHs-MMCuBrK6d8_2jGQ_-7QkA@mail.gmail.com>
Message-ID: <20170724.134144.562191102829366953.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>
Date: Wed, 19 Jul 2017 10:09:13 -0500

> On Tue, Jul 18, 2017 at 4:51 PM, David Miller <davem@davemloft.net> wrote:
>> From: Rob Herring <robh@kernel.org>
>> Date: Tue, 18 Jul 2017 16:43:19 -0500
>>
>>> Now that we have a custom printf format specifier, convert users of
>>> full_name to use %pOF instead. This is preparation to remove storing
>>> of the full path string for each node.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>
>> Acked-by: David S. Miller <davem@davemloft.net>
> 
> The dependency went into 4.13. You can take this thru netdev.

Ok, applied to net-next.

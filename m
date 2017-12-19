From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 19 Dec 2017 19:59:17 +0100
Subject: [net-next: PATCH 0/8] Armada 7k/8k PP2 ACPI support
In-Reply-To: <20171219.134810.48027351795338458.davem@davemloft.net>
References: <1513588684-15647-1-git-send-email-mw@semihalf.com>
 <20171219.134810.48027351795338458.davem@davemloft.net>
Message-ID: <CAPv3WKddg82waiapD8JzH0pCsWVTE2iT0LFz7PCYrrDDpXqmbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

2017-12-19 19:48 GMT+01:00 David Miller <davem@davemloft.net>:
> From: Marcin Wojtas <mw@semihalf.com>
> Date: Mon, 18 Dec 2017 10:17:56 +0100
>
>> Above support configures 1G to use its PHY normally. 10G can work now
>> only with the link interrupt mode. Somehow reading of the
>> string property in fwnode_mdiobus_child_is_phy works only with
>> DT and cannot cope with 10G PHY nodes as in:
>> https://pastebin.com/3JnYpU0A
>>
>> Above root cause will be further checked. In the meantime I will
>> appreciate any comments or remarks for the kernel patches.
>
> I would like you to figure this out before these changes go in.
>

Of course! v2 will not have such problem, I've been waiting however
for the feedback about the ACPI representation. Anyway, I'm strongly
leaning towards using _ADR/_CID objects in PHY's nodes for ACPI, so
maybe I'll just issue the v2 in order to push the discussion a bit
forward.

Thanks,
Marcin

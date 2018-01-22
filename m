From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 22 Jan 2018 17:09:29 +0100
Subject: [net-next: PATCH v4 0/7] Armada 7k/8k PP2 ACPI support
In-Reply-To: <20180122.105750.1953487955261969355.davem@davemloft.net>
References: <CAPv3WKeqEd6Hcy0NdPpiVVA1ioUYY4zs_0zai2gwkCPtM1yaJg@mail.gmail.com>
 <20180122.093525.1549534484738907077.davem@davemloft.net>
 <20180122144342.GB16923@lunn.ch>
 <20180122.105750.1953487955261969355.davem@davemloft.net>
Message-ID: <CAPv3WKey+JHrgasLigMFH5vAdjfz0Z18z0BVF1AQ_poV5CgQbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-01-22 16:57 GMT+01:00 David Miller <davem@davemloft.net>:
> From: Andrew Lunn <andrew@lunn.ch>
> Date: Mon, 22 Jan 2018 15:43:42 +0100
>
>> On Mon, Jan 22, 2018 at 09:35:25AM -0500, David Miller wrote:
>>> From: Marcin Wojtas <mw@semihalf.com>
>>> Date: Mon, 22 Jan 2018 14:00:37 +0100
>>>
>>> > There's a discussion about the ACPI vs generic MDIO/PHY change under
>>> > initial version of the patchset, however the patches in question were
>>> > for now abandoned from further re-sends.
>>>
>>> But doesn't the results of that discussion determine whether the way ACPI
>>> is being used in this patch series is what we want to do or not?
>>
>> Hi David
>>
>> The patches submitted here don't involve any ACPI for MDIO or PHY. It
>> is all MAC. And it is using standard ACPI primitives for devices,
>> nothing new.
>>
>> It is not setting any precedence for MDIO and PHY. That is totally out
>> of scope for these patches. Whatever is decided for MDIO and PHY can
>> be added later.
>
> Thanks for all of the clarifications.
>
> Series applied to net-next, thank you.

Great, thanks!

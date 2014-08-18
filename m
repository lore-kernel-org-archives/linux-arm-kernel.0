From: a.spyridakis@virtualopensystems.com (Alexander Spyridakis)
Date: Mon, 18 Aug 2014 19:08:59 +0200
Subject: [Linaro-acpi] [PATCH v2 00/18] Introduce ACPI for ARM64 based on
 ACPI 5.1
In-Reply-To: <53E050B2.2080609@linaro.org>
References: <1407166105-17675-1-git-send-email-hanjun.guo@linaro.org>
 <CAJRNFK+UfJhGR65tOecy=X+YdHQHiNPZ4p_p8LUxhRL3GW5gFw@mail.gmail.com>
 <53E050B2.2080609@linaro.org>
Message-ID: <CAJRNFKJtbfYEkYWcyXPOfRU9D4MVhabn5X1ZumZMSQFQ=S=j5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Yes, I think so. If you meet any problem , please let us know, and we will
> update the wiki.
>
>>
>> Should I assume that UEFI is mandatory (alternative being the aarch64
>> bootwrapper), as described in Documentation/arm64/arm-acpi.txt?
>
> Yes, UEFI is mandatory if you want to use ACPI.

Hello Hanjun,

What tables do you use for the foundation model (or AEMv8)?

The ones found in this repository:
git://git.linaro.org/leg/acpi/acpi-asl.git are ACPIv5.0, and when the
kernel gets pointed to them acpi is disabled because it expects an
FADT v5.1 or later. Of course building these tables with latest ACPICA
also fails.

Regards.

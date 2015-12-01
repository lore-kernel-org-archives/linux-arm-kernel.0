From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 00:18:27 +0100
Subject: [PATCH] Enable PCIe PHY support in Cygnus
In-Reply-To: <565E2969.7000500@gmail.com>
References: <1447870619-2828-1-git-send-email-rjui@broadcom.com>
 <5654FCF5.40406@gmail.com> <565E2969.7000500@gmail.com>
Message-ID: <4359956.cn9R5kOVVW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 15:12:41 Florian Fainelli wrote:
>   CC      lib/bitmap.o
> 
> I added an #address-cells = <0> and #size-cells = <1> to fix this, since
> your reg property is a single digit.

Did you mean #address-cells = <1> and #size-cells = <0>?

	Arnd

From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2016 16:38:26 +0200
Subject: [PATCH V6 00/13] Support for generic ACPI based PCI host
 controller
In-Reply-To: <5714E224.1030307@semihalf.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <CAKc_7PVC6O4oh+bTmpLQRrhHrqGbaKB2hynecKOLmc5fBc-VVQ@mail.gmail.com>
 <5714E224.1030307@semihalf.com>
Message-ID: <4253385.YPSgBqNLfg@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2016 15:33:24 Tomasz Nowicki wrote:
> 
> Of course we can split discussion into the two topics:
> 1. ECAM based ACPI host controller - patches [1-10]
> 2. Quirks handling and examples.
> 
> IMO, it is very helpful for reviewers to go with one unified patch set 
> and see the whole picture. Also, as you can see, quirks handling allows 
> people to test it easily with their servers (not only QEMU but real HW).

I think splitting the two would help tremendously. The regular
PCI support should just get merged (it should have been completed
years ago when ACPI for ARM64 was first implemented), while the quirks
handling contains all ugly nonstandard hacks we have to be careful
about.

	Arnd

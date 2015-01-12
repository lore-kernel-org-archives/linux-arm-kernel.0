From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Jan 2015 20:55:31 +0100
Subject: [RFC] ACPI on arm64 TODO List
In-Reply-To: <20150112193905.GB5281@amd>
References: <548F9668.6080900@linaro.org>
 <CACxGe6ub0UsUNs1-2NziK_sGEtpxTjcDD+Eto3YOsNkvWxaNcw@mail.gmail.com>
 <20150112193905.GB5281@amd>
Message-ID: <6510884.pqfMoSc7Kv@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 January 2015 20:39:05 Pavel Machek wrote:
> 
> Ok, so what is the primary reason? As far as I could tell it is
> "Microsoft wants ACPI" and "hardware people want Microsoft" and
> "fragmentation is bad so we do ACPI" (1) (and maybe "someone at RedHat
> says they want ACPI" -- but RedHat people should really speak for
> themselves.)

I can only find the first two in Grant's document, not the third one,
and I don't think it's on the table any more. The argument that was
in there was that for a given platform that wants to support both
Linux and Windows, they can use ACPI and Linux should work with that,
but that is different from "all servers must use ACPI", which would
be unrealistic.

	Arnd

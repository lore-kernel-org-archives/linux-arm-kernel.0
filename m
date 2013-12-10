From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 10 Dec 2013 10:56:02 +0100
Subject: [Linaro-acpi] [RFC part1 PATCH 1/7] ACPI: Make ACPI core running
 without PCI on ARM64
In-Reply-To: <20131209170617.GC30717@srcf.ucam.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <20131209115050.GA19163@arm.com> <52A5C024.5050702@linaro.org>
 <201312091735.05014.arnd@arndb.de>
 <20131209170617.GC30717@srcf.ucam.org>
Message-ID: <CACRpkdYyiLAGerKuOjYO2eGz7cEWvy=SjD5Z1fo_0yU6Uwy7tA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 9, 2013 at 6:06 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Mon, Dec 09, 2013 at 05:35:04PM +0100, Arnd Bergmann wrote:
>
>> Exactly. In particular we don't want people to get the wrong idea about
>> where we are heading, so making it possible to use this code on embedded
>> systems for me is a reason *not* to take the patch.
>
> People are trying to deploy ACPI-based embedded x86, and most of the
> ACPI/DT integration discussion seems to have been based on the idea that
> this is a worthwhile thing to support.

I have only seen Intel doing this, are there more people doing that?

As noted on patch [0/7] I still get patches for embedded x86 which
use ISA-style probing for embedded x86, e.g:
http://marc.info/?l=linux-gpio&m=138559852307673&w=2

At the same time some people are refining SFI (simple firmware
interface) support for GPIO, albeit I think that was for elder
embedded x86'es.

Yours,
Linus Walleij

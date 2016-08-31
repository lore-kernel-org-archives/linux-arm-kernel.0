From: tn@semihalf.com (Tomasz Nowicki)
Date: Wed, 31 Aug 2016 14:10:57 +0200
Subject: [RFC PATCH V5 0/5] ECAM quirks handling for ARM64 platforms
In-Reply-To: <CADaLND=pbbtVZt6bg6Lg-21v3_SU+qDJGGDH0Qf+9maf8oTA5w@mail.gmail.com>
References: <1470661002-26213-1-git-send-email-tn@semihalf.com>
 <CADaLND=pbbtVZt6bg6Lg-21v3_SU+qDJGGDH0Qf+9maf8oTA5w@mail.gmail.com>
Message-ID: <0fda1583-f95f-5fe0-b8b7-ae1e2c49db6b@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30.08.2016 23:20, Duc Dang wrote:
> On Mon, Aug 8, 2016 at 5:56 AM, Tomasz Nowicki <tn@semihalf.com> wrote:
>>
>> Quirk handling relies on an idea of matching MCFG OEM ID, TABLE ID and
>> revision (the ones from standard header of MCFG table).
>>
>> Static array is used to keep quirk entries. Each entry consists of
>> mentioned MCFG IDs along with custom pci_ops structure and initialization call.
>>
>> As an example, the last patch presents quirk handling mechanism usage for
>> ThunderX PEM driver.
>
> Hi Tomasz,
>
> Are you planning to change this series into a real one (not RFC) any time soon?

Yes, but first I would like to collect more feedback.

BTW please respond to https://lkml.org/lkml/2016/8/8/273
This series misses ACPI mailing list so I decided to resend it.

Tomasz

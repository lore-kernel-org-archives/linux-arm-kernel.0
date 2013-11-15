From: lho@apm.com (Loc Ho)
Date: Thu, 14 Nov 2013 18:19:30 -0800
Subject: UEFI Clock
In-Reply-To: <CAOesGMifEvRJuYXB6XtJ==OLmdqXezdF0uv5Gr0s9Wqw7ytg_w@mail.gmail.com>
References: <CAPw-ZTnPecp+VYfn5yukrpFNk5sCr5LVDNFty0sLhY=NNhNkXg@mail.gmail.com>
 <CAOesGMifEvRJuYXB6XtJ==OLmdqXezdF0uv5Gr0s9Wqw7ytg_w@mail.gmail.com>
Message-ID: <5815991615939825395@unknownmsgid>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

For the acpi, is that part of the acpi framework? If so, can you point
me to the location of the code for reference?

-Loc

Sent from my iPhone

> On Nov 14, 2013, at 17:36, Olof Johansson <olof@lixom.net> wrote:
>
>> On Thu, Nov 14, 2013 at 4:01 PM, Loc Ho <lho@apm.com> wrote:
>> Hi Mike,
>>
>> I will be looking into covering the clock driver to support UEFI.
>> Before I do this, can someone explain to me how x86 system handle each
>> IP clock as I don't see such thing?
>
> Most of it is handled in firmware and/or via ACPI.
>
> In some cases the clocks are handled per driver instead, i.e. graphics
> drivers have their own clock management for their part of the system,
> etc.
>
>
> -Olof

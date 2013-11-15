From: olof@lixom.net (Olof Johansson)
Date: Thu, 14 Nov 2013 18:23:59 -0800
Subject: UEFI Clock
In-Reply-To: <5815991615939825395@unknownmsgid>
References: <CAPw-ZTnPecp+VYfn5yukrpFNk5sCr5LVDNFty0sLhY=NNhNkXg@mail.gmail.com>
 <CAOesGMifEvRJuYXB6XtJ==OLmdqXezdF0uv5Gr0s9Wqw7ytg_w@mail.gmail.com>
 <5815991615939825395@unknownmsgid>
Message-ID: <CAOesGMhWoR+8GbiubpSBPqLQ=vQunvUz1Nz+Xgg3gSHrrFNdXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[switched to correct devicetree list, even though this is all ACPI discussion]

On Thu, Nov 14, 2013 at 6:19 PM, Loc Ho <lho@apm.com> wrote:
> Hi,
>
> For the acpi, is that part of the acpi framework? If so, can you point
> me to the location of the code for reference?

Please don't top post replies when someone else has taken the time to
post a reply in-line. It's bad form for kernel mailing lists.

Sorry for being vague in my initial email -- I did mean to say that
most power management such as moving devices to standby modes is done
through ACPI calls on x86, I believe -- I.e. D0-D2,D3hot/D3cold is
handled through ACPI. I don't know if there's more fine-grained
runtime clock control done today.


-Olof

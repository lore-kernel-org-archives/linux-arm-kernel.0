From: lho@apm.com (Loc Ho)
Date: Sat, 23 Jul 2016 23:31:18 -0700
Subject: hwmon: xgene: Add support for X-Gene hwmon driver
In-Reply-To: <71a96a29-78e3-f251-dd8f-583031461678@riken.jp>
References: <02814a96-c620-c4af-e278-40432f6f701f@riken.jp>
 <9D204F6B-7C99-4543-87BF-4D9FC3F6475C@apm.com>
 <71a96a29-78e3-f251-dd8f-583031461678@riken.jp>
Message-ID: <CAPw-ZTkXCe5ycO=e7FohbCbTXhMhqob8=a5gdOPezLMc0ubb=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Itaru,

On Sat, Jul 23, 2016 at 10:04 PM, Itaru Kitayama
<itaru.kitayama@riken.jp> wrote:
>
> Hi Hoan,
>
> I didn't mention in my previous post, though I think I'm using fairly recent version of Tianocore F/W, and I can confirm there's the PCCT table,
>
> [    0.000000] ACPI: PCCT 0x00000047FA826000 000300 (v01 APM    XGENE 00000003      01000013)
>
> is this still not enough? If that's the case, I'll talk to APM for
> their latest development Tianocore version.

You will need the to be released FW version 3.06.xx or above. This new
FW won't be official release until at least a few months. If you want
to test this new firmware, we can get you an earlier image but there
will be very limited support. Though, Hoan will support you when
possible.

> Also, if you or your folks can fold your patch set into APM's xgene-next
> GitHub repo, that would help me to keep up with the development.

This can only get pull into xgene-next if it had accepted upstream.

-Loc

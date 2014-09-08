From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 8 Sep 2014 10:10:45 +0900
Subject: [PATCH v3 0/3] ARM: shmobile: sh73a0: Enable CMT1 device using DT
In-Reply-To: <1410137828-4769-1-git-send-email-horms+renesas@verge.net.au>
References: <1410137828-4769-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CANqRtoRYvcEgbpK3=s3i6X2nikaeu6S1cdNZU3ycbWhXE_3oow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Sep 8, 2014 at 9:57 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> Hi,
>
> this is a slightly modified version of this change which
> was previously available in
> "[PATCH v2 00/10] sh73a0 common clock framework implementation"
>
> The purpose of breaking or this change is to allow it to
> be applied independently of the changes in the above mentioned series.
>
> The changes are as follows:
> - Don't use DT clocks as they are added by the above mentioned series
>   and thus not present yet.
> - Add patch to use SoC-specific 48-bit CMT compat string.
>
> Simon Horman (1):
>   ARM: shmobile: sh73a0: Use SoC-specific 48-bit CMT compat string
>
> Ulrich Hecht (2):
>   ARM: shmobile: sh73a0: Add CMT1 device to DT
>   ARM: shmobile: kzm9g-reference: Enable CMT1 in device tree

Looking good, thanks for doing this!

Acked-by: Magnus Damm <damm+renesas@opensource.se>

Cheers,

/ magnus

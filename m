From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 29 Apr 2014 13:32:15 +0000
Subject: [PATCH v4 00/11] CCF support for Renesas r7s72100
In-Reply-To: <1398765822-2314-1-git-send-email-wsa@the-dreams.de>
References: <1398765822-2314-1-git-send-email-wsa@the-dreams.de>
Message-ID: <CANqRtoR0SXCrYZDFXVKZbHWqNDsVmpSxwdBcQ-OWO4Gxhjk1OQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Tue, Apr 29, 2014 at 10:03 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> This series moves the r7s72100 platfrom from the legacy clock implementation to
> the common clock framework.
>
> This series has been tested with the renesas-devel-v3.15-rc2-20140428 tag.
> If you want to boot into a console, you have a runtime dependency [1].
>
> Changes since V4:
>
> * only use dt alias for scif2

Thanks for fixing up the dt alias bits and sending a V4. This series
looks good to me.

Acked-by: Magnus Damm <damm+renesas@opensource.se>

Cheers,

/ magnus

From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Tue, 18 Sep 2012 10:40:07 +0530
Subject: [PATCH 0/2] Replace the obsolete preset API by timings API
In-Reply-To: <1344429020-27616-1-git-send-email-prabhakar.lad@ti.com>
References: <1344429020-27616-1-git-send-email-prabhakar.lad@ti.com>
Message-ID: <CA+V-a8t2H_1xJb4MCfzSzHtrjTbq7HFNjuWtgtwWERS_3qZH1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mauro/Sekhar

On Wed, Aug 8, 2012 at 6:00 PM, Prabhakar Lad <prabhakar.lad@ti.com> wrote:
> This first patch replaces the obsolete preset API by timings
> API for davinci VPBE, appropriate chnages in machine file for
> dm644x in which VPBE is enabled. And the second patch adds support for
> timings API for ths7303 driver. Sending them as s series
> since VPBE uses the ths7303 driver.
>
> Hans Verkuil (1):
>   dm644x: replace the obsolete preset API by the timings API.
>
> Manjunath Hadli (1):
>   ths7303: enable THS7303 for HD modes
>
Can you pull this patchset ? Please inform me if anything is
needed from my side.

Regards,
--Prabhakar

>  arch/arm/mach-davinci/board-dm644x-evm.c   |   15 ++--
>  arch/arm/mach-davinci/dm644x.c             |   17 +---
>  drivers/media/video/davinci/vpbe.c         |  110 ++++++++++++----------------
>  drivers/media/video/davinci/vpbe_display.c |   60 +++++++--------
>  drivers/media/video/davinci/vpbe_venc.c    |   25 +++---
>  drivers/media/video/ths7303.c              |  107 +++++++++++++++++++++++----
>  include/media/davinci/vpbe.h               |   14 ++--
>  include/media/davinci/vpbe_types.h         |    8 +--
>  include/media/davinci/vpbe_venc.h          |    2 +-
>  9 files changed, 202 insertions(+), 156 deletions(-)
>
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source at linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source

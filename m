From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 27 Jun 2017 17:33:21 +0200
Subject: [PATCH v2 00/15] staging: fsl-mc: clean up header files
In-Reply-To: <20170627144135.15599-1-laurentiu.tudor@nxp.com>
References: <20170627144135.15599-1-laurentiu.tudor@nxp.com>
Message-ID: <CAK8P3a2pD5+kd5NLbkJ_ppDb8jgNE7Cuxm=GLHf-ZgsLgoq9Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 4:41 PM,  <laurentiu.tudor@nxp.com> wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> This patch series contain mainly clean-ups of the mc-bus header files
> with the final goal of reorganizing them in just 2 files: a public
> and a private one, as per GregKH suggestion [1].
> Here's a summary of the header reorganizing:
>  - existing mc.h used as public header (contained most of the public API)
>  - existing fsl-mc-private.h used for private header
>  - mc-bus.h merged both in public and private header
>  - mc-sys.h and mc-cmd.h merged in public header
>  - dprc.h made private
>  - dpmng.h deleted
>
> [1] https://patchwork.kernel.org/patch/9775683/
>
> version 2 changes
>  - fix compilation issue
>  - reordered a comparison, be consistent when checking strcmp() return
>    (Joe Perches, first two patches)

It looks like v1 was already merged into staging-next, so the changes would
have to be relative to what's already merged, rather than replacing them.

I also just sent a fixup for the Makefile bug, probably others have pointed
that out too.

       Arnd

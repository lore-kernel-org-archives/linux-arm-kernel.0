From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Tue, 7 Mar 2017 17:12:31 +0000
Subject: [PATCH] media: vpif: use a configurable i2c_adapter_id for vpif
 display
In-Reply-To: <1487268481-6127-1-git-send-email-bgolaszewski@baylibre.com>
References: <1487268481-6127-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <CA+V-a8umdNxUAfnY97u+UVYYbi5h79ZXymeqcoW-ZKbXwJJPOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

Thanks for the patch.

On Thu, Feb 16, 2017 at 6:08 PM, Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> The vpif display driver uses a static i2c adapter ID of 1 but on the
> da850-evm board in DT boot mode the i2c adapter ID is actually 0.
>
> Make the adapter ID configurable like it already is for vpif capture.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  arch/arm/mach-davinci/board-da850-evm.c       | 1 +
>  drivers/media/platform/davinci/vpif_display.c | 2 +-
>  include/media/davinci/vpif_types.h            | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
--Prabhakar Lad

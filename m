From: robherring2@gmail.com (Rob Herring)
Date: Fri, 16 Jan 2015 08:11:23 -0600
Subject: [PATCH v5 1/5] Documentation: DT: Renamed of-serial.txt to
 8250.txt
In-Reply-To: <1421402411-3479-2-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1421402411-3479-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1421402411-3479-2-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <CAL_JsqL9hkfuGi-BmRHTZ=F3KVL8miu2LXkftbswpVuuSx0dtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 16, 2015 at 4:00 AM, Chunyan Zhang
<chunyan.zhang@spreadtrum.com> wrote:
> The file of-serial.txt was only for 8250 compatible UART implementations,
> so renamed it to 8250.txt to avoid confusing other persons.
> This is suggested by Arnd, see:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/291455.html
>
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

This is pretty much un-related to the rest of the series, so I will apply it.

Rob

> ---
>  .../bindings/serial/{of-serial.txt => 8250.txt}    |    0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/serial/{of-serial.txt => 8250.txt} (100%)
>
> diff --git a/Documentation/devicetree/bindings/serial/of-serial.txt b/Documentation/devicetree/bindings/serial/8250.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/serial/of-serial.txt
> rename to Documentation/devicetree/bindings/serial/8250.txt
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

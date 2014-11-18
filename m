From: robherring2@gmail.com (Rob Herring)
Date: Tue, 18 Nov 2014 11:00:21 -0600
Subject: [PATCHv3 01/12] of: add "micron" vendor prefix for Micron
In-Reply-To: <9cfc5635b14f36e68c499015c6a722804b407f29.1416266432.git.arno@natisbad.org>
References: <cover.1416266432.git.arno@natisbad.org>
 <9cfc5635b14f36e68c499015c6a722804b407f29.1416266432.git.arno@natisbad.org>
Message-ID: <CAL_JsqKrEoRvt97k+7UHBsNFU739w7BeQbXf5V2TZ2OrmS1Afg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 5:26 PM, Arnaud Ebalard <arno@natisbad.org> wrote:
>
> Micron vendor prefix is not listed yet in vendor-prefixes.txt file. Even
> if the expected vendor prefix should be the NASDAQ symbol ("mu" in that
> case), it seems reasonable to use "micron" here because it is what is
> already found at various locations (e.g. under arch/arm/boot/dts/ for
> instance).

Already have the same patch queued up.

Rob

>
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 723999d73744..55a3a7f19063 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -96,6 +96,7 @@ mitsubishi    Mitsubishi Electric Corporation
>  mosaixtech     Mosaix Technologies, Inc.
>  moxa   Moxa
>  mpl    MPL AG
> +micron Micron Technology, Inc.
>  mundoreader    Mundo Reader S.L.
>  murata Murata Manufacturing Co., Ltd.
>  mxicy  Macronix International Co., Ltd.
> --
> 2.1.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

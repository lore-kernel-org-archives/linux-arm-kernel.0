From: mylene.josserand@bootlin.com (=?UTF-8?B?TXlsw6huZQ==?= Josserand)
Date: Wed, 18 Apr 2018 12:03:27 +0200
Subject: [PATCH v6 11/11] ARM: shmobile: Convert file to use cntvoff
In-Reply-To: <CAMuHMdU9soQuNMC59Y2AQdTmXbWBz-P3EFfZ6NYGKukJVukKgg@mail.gmail.com>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-12-mylene.josserand@bootlin.com>
 <CAMuHMdU9soQuNMC59Y2AQdTmXbWBz-P3EFfZ6NYGKukJVukKgg@mail.gmail.com>
Message-ID: <20180418120327.0f707abf@dell-desktop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, 18 Apr 2018 11:36:27 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Myl?ne,
> 
> On Mon, Apr 16, 2018 at 11:50 PM, Myl?ne Josserand
> <mylene.josserand@bootlin.com> wrote:
> > Now that a common function is available for CNTVOFF's
> > initialization, let's convert shmobile-apmu code to use
> > this function.  
> 
> Thanks for your patch, works fine on Renesas ALT with R-Car E2,
> which suffers from lack of CNTVOFF initialization.

Great to know that it works on this board.

> 
> > Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>  
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

Thank you again for testing it :)

Best regards,

-- 
Myl?ne Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

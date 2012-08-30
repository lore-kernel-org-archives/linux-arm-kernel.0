From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 30 Aug 2012 13:31:48 +0100
Subject: [PATCH 18/22] ARM: ux500: Rename MSP board file to something
 more meaningful
In-Reply-To: <CACRpkdaJcfLNzZ4s4NOyBLROjNbNfP8m0EewFkwe6tTrCS-Hog@mail.gmail.com>
References: <1344527268-5964-1-git-send-email-lee.jones@linaro.org>
 <1344527268-5964-19-git-send-email-lee.jones@linaro.org>
 <CACRpkdaJcfLNzZ4s4NOyBLROjNbNfP8m0EewFkwe6tTrCS-Hog@mail.gmail.com>
Message-ID: <20120830123146.GF14145@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 01:20:32PM +0200, Linus Walleij wrote:
> On Thu, Aug 9, 2012 at 5:47 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > The 'msp' board file does more than just register MSP devices. It
> > also registers some other components necessary to get audio working
> > on ux500 based platforms; such as the PCM and Machine Drivers. For
> > that reason we're changing the filename to be more encompassing -
> > 'audio'.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Ideally I want Ola to confirm this but it looks OK to me.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Poke for Ola.

I'm guessing it's okay, as Ola told me to rename the file 'msp' -> 'audio'.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

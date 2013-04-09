From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 9 Apr 2013 20:12:56 +0100
Subject: [PATCH 7/8] dmaengine: ste_dma40: Use the BIT macro to replace
 ugly '(1 << x)'s
In-Reply-To: <CAHLZz133b6kydVwh0_Cn2yg-Q_MeUF+Z-7+CMY7TkB7KK2ssAQ@mail.gmail.com>
References: <1365532783-27425-1-git-send-email-lee.jones@linaro.org>
 <1365532783-27425-7-git-send-email-lee.jones@linaro.org>
 <CAHLZz133b6kydVwh0_Cn2yg-Q_MeUF+Z-7+CMY7TkB7KK2ssAQ@mail.gmail.com>
Message-ID: <20130409191256.GG25316@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 09 Apr 2013, Harvey Harrison wrote:

> On Tue, Apr 9, 2013 at 11:39 AM, Lee Jones <lee.jones@linaro.org> wrote:
> >
> > The aim is to make the code that little more readable.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> 
> >
> >  #define MAX(a, b) (((a) < (b)) ? (b) : (a))
> 
> Not part of your patch, but probably a good idea to switch to the
> generic MAX macro, this
> one is evaluating its args twice.

Sure, thanks for the heads-up.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

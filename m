From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 9 Jun 2016 16:30:34 +0100
Subject: [PATCH 8/8] dmaengine: Remove site specific OOM error messages
 on kzalloc
In-Reply-To: <CACRpkdaf1d8CvBmFCT+bWiXR9ddJ0Mpu5hMi2fzR6sLCXt3EqA@mail.gmail.com>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
 <1465321121-22238-9-git-send-email-peter.griffin@linaro.org>
 <CACRpkdaf1d8CvBmFCT+bWiXR9ddJ0Mpu5hMi2fzR6sLCXt3EqA@mail.gmail.com>
Message-ID: <20160609153034.GB5438@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 08 Jun 2016, Linus Walleij wrote:

> On Tue, Jun 7, 2016 at 7:38 PM, Peter Griffin <peter.griffin@linaro.org> wrote:
> 
> > If kzalloc() fails it will issue it's own error message including
> > a dump_stack(). So remove the site specific error messages.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> A few subsystems may use a cleanup like this...
> I wonder how many unnecessary prints I've introduced
> myself :P

Wolfram did some analysis on this a while back.  IIRC he also
presented on his findings at ELC(?).
 
-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 28 Jan 2013 08:49:12 +0000
Subject: [PATCH 10/26] mfd: ab8500-debugfs: Wake-up device on debugfs IRQ
In-Reply-To: <20130127235309.GP1174@sortiz-mobl>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
 <1358254566-12419-11-git-send-email-lee.jones@linaro.org>
 <20130127235309.GP1174@sortiz-mobl>
Message-ID: <20130128084912.GF15873@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Jan 2013, Samuel Ortiz wrote:

> Hi Lee,
> 
> On Tue, Jan 15, 2013 at 12:55:50PM +0000, Lee Jones wrote:
> > Ensure the device wakes up if the debugfs IRQ fires if we're
> > in suspend mode.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/ab8500-debugfs.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> Please squash this one with the previous one.

I'll fixup.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

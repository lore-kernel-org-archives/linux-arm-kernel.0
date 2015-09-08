From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 8 Sep 2015 17:26:59 +0100
Subject: [PATCH linux-next v9 0/3] mfd: flexcom: add a driver for Flexcom
In-Reply-To: <55EF070C.7020600@atmel.com>
References: <cover.1441118159.git.cyrille.pitchen@atmel.com>
 <55EF070C.7020600@atmel.com>
Message-ID: <20150908162659.GA3260@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 08 Sep 2015, Cyrille Pitchen wrote:

> Hi all,
> 
> Le 01/09/2015 16:46, Cyrille Pitchen a ?crit :
> > ChangeLog
> > 
> > v9:
> > - go back to v5 (use the new "atmel,flexcom-mode" DT property).
> > - fix the name of the spi node in the DT example: from spi at f8034400 to
> >   spi at 400
> > - align the fields of the struct platform_driver atmel_flexcom_driver as
> >   suggested by Lee Jones.
> > 
> [...]
> 
> Are there any remaining blocking points for this series ?

Yes.  The merge window is open, so it's Maintainer sleepy time [0].

Will get back to reviewing next week probably.

[0] AKA: Breath out and catch up with real-work for a bit.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 May 2014 10:52:14 +0200
Subject: [PATCH] watchdog: sunxi: Fix compilation with C=2
In-Reply-To: <536FD3B3.3030100@elopez.com.ar>
References: <1396632265-16124-1-git-send-email-emilio@elopez.com.ar>
 <533EF39D.6090907@roeck-us.net> <536FD3B3.3030100@elopez.com.ar>
Message-ID: <20140515085214.GP29258@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 11, 2014 at 04:46:59PM -0300, Emilio L?pez wrote:
> El 04/04/14 15:02, Guenter Roeck escribi?:
> >On 04/04/2014 10:24 AM, Emilio L?pez wrote:
> >>When compiling sunxi_defconfig while using C=2, the following error
> >>causes the compilation to fail:
> >>
> >>     drivers/watchdog/sunxi_wdt.c:60:15: error: constant 0b0001 is not
> >>a valid number
> >>
> >>Fix it by using hex notation instead of the non-standard binary one
> >>
> >>Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> >
> >Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >
> 
> Wim, Maxime, any comments on this?

I'm fine with this. Wim? Do you want to take this patch, or can we
have an Acked-by?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140515/1c5a5fa7/attachment.sig>

From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 31 Dec 2013 11:37:07 -0800
Subject: [RESEND PATCH v7 1/5] omap3isp: Modify clocks registration to
 avoid circular references
In-Reply-To: <20131219080729.18119.42456@quantum>
References: <1386177127-2894-1-git-send-email-s.nawrocki@samsung.com>
 <1386177127-2894-2-git-send-email-s.nawrocki@samsung.com>
 <52AF7B4D.2010305@gmail.com> <20131219080729.18119.42456@quantum>
Message-ID: <20131231193707.12054.68169@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Mike Turquette (2013-12-19 00:07:29)
> Quoting Sylwester Nawrocki (2013-12-16 14:14:37)
> > Hi Mike,
> > 
> > Laurent has already taken this patch into his tree, could you apply
> > the remaining ones to your clk tree so this series has enough exposure
> > in -next ?
> 
> I've taken this in privately to do a little testing. If all goes well
> then I'll push it out to clk-next very soon.

This is in clk-next now. Hopefully nothing bad will happen when it hits
linux-next ;-)

Regards,
Mike

> 
> Thanks!
> Mike
> 
> > 
> > Thanks,
> > Sylwester

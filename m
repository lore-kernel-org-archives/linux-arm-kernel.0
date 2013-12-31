From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 31 Dec 2013 01:27:32 +0000
Subject: [PATCH] regulator: act8865: register all regulators regardless
 of how many are used
In-Reply-To: <20131230120327.GN31886@sirena.org.uk>
References: <1388023041-25785-1-git-send-email-wenyou.yang@atmel.com>
 <20131230120327.GN31886@sirena.org.uk>
Message-ID: <B256D81BAE5131468A838E5D7A24364172F308AA@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Monday, December 30, 2013 8:03 PM
> To: Yang, Wenyou
> Cc: lgirdwood at gmail.com; plagnioj at jcrosoft.com; Ferre, Nicolas; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH] regulator: act8865: register all regulators regardless
> of how many are used
> 
> On Thu, Dec 26, 2013 at 09:57:21AM +0800, Wenyou Yang wrote:
> > As Mark pointed out, the driver should register all regulators
> > regardless of how many are used in the system in order to aid diagnostics.
> 
> Thanks for doing this but it doesn't apply against the current code due to
> the fixups from Axel.  Can you please check and resend?
Thanks, I will send a new version.

Happy New Year!

Best Regards,
Wenyou Yang

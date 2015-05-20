From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 May 2015 11:07:03 -0700
Subject: [PATCH RESEND] mach-omap2:Remove calls to deprecacted
 marco,PTR_RET in the files,fb.c and pmu.c
In-Reply-To: <1431958079-486-1-git-send-email-xerofoify@gmail.com>
References: <1431958079-486-1-git-send-email-xerofoify@gmail.com>
Message-ID: <20150520180703.GI10274@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicholas Krause <xerofoify@gmail.com> [150518 07:09]:
> This removes two calls to the deprecated marco,PTR_RET in
> the files,fb.c and pmu.c for the functions,omap_init_vrfb
> and omap_init_pmu respectfully. Furthermore these are now
> replaced by calling the correctly non deprecacted function,
> PTR_ERR_OR_ZERO in both functions.

I've applied the original version today as they seem to be
the same.

Thanks,

Tony

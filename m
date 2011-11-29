From: vishwanath.bs@ti.com (Vishwanath Sripathy)
Date: Tue, 29 Nov 2011 16:52:47 +0530
Subject: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain support via
 hwmod mux
In-Reply-To: <87pqh3qvkt.fsf@ti.com>
References: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
 <87pqh3qvkt.fsf@ti.com>
Message-ID: <1e686270c099fa4a270b6b01e6ac585c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at ti.com]
> Sent: Tuesday, November 08, 2011 6:28 AM
> To: Vishwanath BS
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCHv2 0/7]ARM: OMAP3PLUS PM: Add IO DaisyChain
> support via hwmod mux
>
> Hi Vishwa,
>
> Vishwanath BS <vishwanath.bs@ti.com> writes:
>
> > The folowing patch series provides IO Daisychain feature via omap
> hwmod mux
> > framework.
>
> The series looks OK at first glance, but needs a refresh against
> current
> mainline.
OK.
>
> Can you refresh this against Tony's 'fixes' branch and re-test.
>
> I tested this on OMAP3430/n900 and noticed that it no longer hit off
> mode from idle.
>
> IOW, If I enable UART timeouts and then enable off mode, I don't
> actually ever hit off during idle.  However, if I do a
> suspend/resume I
> see it hits off mode, then subsequent attempts to hit off during
> idle work.
>
> Can you investigate this?
OK. Let me check that.

Regards
Vishwa
>
> Kevin

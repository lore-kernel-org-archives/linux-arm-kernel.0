From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 6 Jun 2012 09:09:35 +0100
Subject: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500
In-Reply-To: <CACRpkdY=os8B2JEVijHzdfqUN_Q075MLoVsk3U=owAPhmcNUHg@mail.gmail.com>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
 <4F8BE5B0.4000900@linaro.org>
 <20120604101447.GF8262@n2100.arm.linux.org.uk>
 <4FCDE3D7.9030006@linaro.org>
 <20120605105249.GK8262@n2100.arm.linux.org.uk>
 <CACRpkdY=os8B2JEVijHzdfqUN_Q075MLoVsk3U=owAPhmcNUHg@mail.gmail.com>
Message-ID: <CAF2Aj3jGkG-qj6DTBQPzRzawyJqcncp662k233pRFH+JVtSm6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> > >> > So why is this buggy patch now merged in the mainline kernel?
> > >>
> > >> I guess Chris took it because you said it was fine?
> > >
> > > Err, no.  If you re-read the thread, you'll see that I said your
> > > subsequent patch posted on Thu, 03 May 2012 16:30:48 +0100 with
> > > the devm_kzalloc() was fine.
>

Ah, so the wrong patch was merged?


> > Lee can you provide an incremental fixup that makes the current
>
> > code textually equivalent to what Russell ACKed (devm_kzalloc()),
> > and funnel to Chris for the -rc:s ASAP?
>

It turns out that there is no free internet in my hotel, so it will have to
wait until I'm back from my holiday (Monday).

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog



-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120606/e6cebc03/attachment-0001.html>

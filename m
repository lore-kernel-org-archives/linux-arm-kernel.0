From: tj@kernel.org (Tejun Heo)
Date: Wed, 1 Nov 2017 07:30:47 -0700
Subject: [PATCH] ata: fixes kernel crash while tracing
 ata_eh_link_autopsy event
In-Reply-To: <CAFd313w9W2hHFPJ47y0jeNb1u7=0deLtwcRF=+HXGBYft-QaLw@mail.gmail.com>
References: <1508926976-11467-1-git-send-email-rsahu@apm.com>
 <20171025145450.GA59538@devbig577.frc2.facebook.com>
 <CAFd313w9W2hHFPJ47y0jeNb1u7=0deLtwcRF=+HXGBYft-QaLw@mail.gmail.com>
Message-ID: <20171101143031.GL3252168@devbig577.frc2.facebook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, Oct 31, 2017 at 08:52:44PM +0530, Rameshwar Sahu wrote:
> > probably should take both link and dev and use dev iff it's not NULL.
> >
> 
> Instead of this would it be better to call trace_ata_eh_link_autopsy() if
> dev is not NULL from ata error handler ??

Oh yeah, that'd work too and be probably better.

Thanks.

-- 
tejun

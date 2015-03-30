From: dianders@chromium.org (Doug Anderson)
Date: Mon, 30 Mar 2015 08:47:14 -0700
Subject: [PATCH] mmc: dw_mmc: Consider HLE errors to be data and command
 errors
In-Reply-To: <55189F04.8000404@samsung.com>
References: <1426002490-2014-1-git-send-email-dianders@chromium.org>
 <5502CA4E.9060401@samsung.com>
 <CAD=FV=VX3ix-j4y95W1q8b-aVuVEN+4xsd8WLx2xcE7KPNJwRw@mail.gmail.com>
 <5506707D.40708@samsung.com> <55189F04.8000404@samsung.com>
Message-ID: <CAD=FV=WFAZqAsXOqunt0fxw87M-FruwUrxuzW0MJsG6UvfSjzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jaehoon,

On Sun, Mar 29, 2015 at 5:55 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear Doug,
>
> I'm considering to control HLE error..So holding this patch.
> If this is absolutely necessary patch, let me know, plz.
>
> Best Regards,
> Jaehoon Chung

Sounds OK.  I have certainly applied this locally and the driver isn't
robust against insertions / removals without it, but once the card is
inserted things are OK so it's probably not urgent that it be applied
upstream.  Hopefully we can figure out a better solution...

-Doug

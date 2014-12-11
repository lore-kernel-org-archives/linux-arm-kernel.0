From: dianders@chromium.org (Doug Anderson)
Date: Thu, 11 Dec 2014 08:09:13 -0800
Subject: [PATCH 1/4] regulator: core: Support trying to get close to a
 certain voltage
In-Reply-To: <20141211123106.GU11764@sirena.org.uk>
References: <1418245085-9754-1-git-send-email-dianders@chromium.org>
 <20141210235347.GT11764@sirena.org.uk>
 <CAHNYxRy2t0OVj-+CqQFOfj0zWAGG0j8rmd8SxdNWgBMA2iAfXQ@mail.gmail.com>
 <20141211123106.GU11764@sirena.org.uk>
Message-ID: <CAD=FV=U4RFYx9NXOACrXJZK2bKkosyYnmTZRHkXuaSz-FS9kNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Thu, Dec 11, 2014 at 4:31 AM, Mark Brown <broonie@kernel.org> wrote:
> This is just an implementation detail, everything you're saying here
> applies equally to any user specifying by tolerance rather than range.
> If the reason for doing this is to fix that problem then a new API isn't
> the way to go about it.

OK, I'll give a shot at taking my code and using it as a new
implementation for regulator_set_voltage_tol().  In the SD card code
I'll pick some reasonable tolerances--they won't be exactly what the
spec says, but they ought to be good enough.  If Ulf comes back and
yells at me then we can revisit adding a new API.

Thanks!

-Doug

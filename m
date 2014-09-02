From: dianders@chromium.org (Doug Anderson)
Date: Tue, 2 Sep 2014 09:53:00 -0700
Subject: [PATCH 2/2] dt-bindings: Add input supplies to rk808 bindings
In-Reply-To: <20140902163105.GY29327@sirena.org.uk>
References: <1409674469-12123-1-git-send-email-dianders@chromium.org>
 <1409674469-12123-3-git-send-email-dianders@chromium.org>
 <20140902163105.GY29327@sirena.org.uk>
Message-ID: <CAD=FV=Xnpqhqo4zQPJPUj3=BipeuD0+L4mxN_0zfJheTMnwjLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Tue, Sep 2, 2014 at 9:31 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 02, 2014 at 09:14:29AM -0700, Doug Anderson wrote:
>> The original bindings for rk808 didn't include input supplies.  Add
>> them.
>
> Acked-by: Mark Brown <broonie@linaro.org>
>
> You probably want to send this to Lee...

Good point.  I think it might actually be better for Chris to just
squash my bindings patch into his bindings patch since he still has to
send out another version.  If you haven't applied the regulator patch
by the time he sends his next version he can include my patch in his
series (with your Ack).

Chris did get an Ack for the MFD patch from Lee but I requested some
changes to the regulator patch.  When things look good Chris will add
you back to the CC list for the regulator part of his series.

Thanks!

-Doug

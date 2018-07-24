From: dianders@chromium.org (Doug Anderson)
Date: Tue, 24 Jul 2018 08:11:30 -0700
Subject: [PATCH v9 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <20180724145755.GF13268@sirena.org.uk>
References: <cover.1531531808.git.collinsd@codeaurora.org>
 <56b9d5c38cfe46da1228c54f001a49773c3e31dc.1531531808.git.collinsd@codeaurora.org>
 <CAD=FV=VmfqWRGRMEn+0dzZ8x4R5vVaHbkthXAN91Lm-XmP9Gqg@mail.gmail.com>
 <20180724145755.GF13268@sirena.org.uk>
Message-ID: <CAD=FV=Uo8sT72a0gRitOVoK0SfC-_QixsovW94_LnL6H7QdKvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 24, 2018 at 7:57 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jul 23, 2018 at 01:09:05PM -0700, Doug Anderson wrote:
>
>> I know you are still looking for time to review the RPMh-regulator
>> driver and that's fine.  One idea I had though: if the bindings look
>> OK to you and are less controversial, is there any chance they could
>> land in the meantime?
>
> This appears to have a bunch of dependencies which I've got no idea
> what's going on with the merging of and no idea if they'll affect the
> bindings or anything, nobody's said anything and last I looked it was
> unclear what was going on.

RPMh itself landed in Andy's tree and he sent a pull request on
Saturday.  Feel free to refer to the request ("[GIT PULL] Qualcomm
Driver updates for 4.19") AKA
<https://patchwork.kernel.org/patch/10539125/>.

It doesn't look like arm-soc has picked up Andy's pull request yet
though.  If having it in arm-soc is a requirement then I'm happy to
monitor arm-soc and ping this thread again when it's there.


> I'm kind of hoping that things might have
> sorted themselves out of the merge window.
>
> Some of the decisions in the code have flowed out into the bindings
> before so I'm not keen to merge the bindings separately,

Fair point.  I was thinking that we had pared the driver down enough
now that the bindings were no longer anything other than just
boilerplate bits describing the hardware, but it's obviously your
decision when you're happy to land them.


> and if the
> driver for the thing used to communicate with the device is still in
> review then that's definitely a red flag.

As per above it's been landed, so hopefully this red flag is removed?


-Doug

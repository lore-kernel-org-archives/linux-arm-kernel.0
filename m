From: dianders@chromium.org (Doug Anderson)
Date: Fri, 10 Aug 2018 13:07:14 -0700
Subject: [PATCH v9 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <20180810162920.GG20971@sirena.org.uk>
References: <cover.1531531808.git.collinsd@codeaurora.org>
 <acfc014f3ae3d7feea30be6beaec3e64d96a2723.1531531808.git.collinsd@codeaurora.org>
 <20180810162920.GG20971@sirena.org.uk>
Message-ID: <CAD=FV=V54aOCTLk3J_0=DL0XHJ-Tc77zKzURTwz5PJsioK73+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 10, 2018 at 9:29 AM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 13, 2018 at 06:50:59PM -0700, David Collins wrote:
>
>> +     switch (rpmh_mode) {
>
>> +     default:
>> +             mode = REGULATOR_MODE_INVALID;
>> +     }
>
> I'm not sure why the break statements are being omitted in default
> cases, but I do find myself stopping and trying to figure it out?

Hopefully <https://lore.kernel.org/lkml/20180810200531.88409-1-dianders@chromium.org/>
addresses this?

Thanks!

-Doug

From: robherring2@gmail.com (Rob Herring)
Date: Tue, 25 Aug 2015 08:27:10 -0500
Subject: [PATCH v3 06/14] Documentation: drm/bridge: add document for
 analogix_dp
In-Reply-To: <20150825091534.GB14034@ulmo.nvidia.com>
References: <1439995728-18046-1-git-send-email-ykk@rock-chips.com>
 <1439995834-18363-1-git-send-email-ykk@rock-chips.com>
 <CAL_JsqLz+8RtBucctUj4euXZ3Ac0DvB52N9ONpAerh5T9BiTJg@mail.gmail.com>
 <20150825091534.GB14034@ulmo.nvidia.com>
Message-ID: <CAL_Jsq++RLZo4gvEUTKO8MfEPwSqT2R+bqG22Jsgb2qLgDQFpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 25, 2015 at 4:15 AM, Thierry Reding <treding@nvidia.com> wrote:
> On Sun, Aug 23, 2015 at 06:23:14PM -0500, Rob Herring wrote:
>> On Wed, Aug 19, 2015 at 9:50 AM, Yakir Yang <ykk@rock-chips.com> wrote:
> [...]
>> > +       -analogix,link-rate:
>> > +               max link rate supported by the eDP controller.
>> > +                       LINK_RATE_1_62GBPS = 0x6, LINK_RATE_2_70GBPS = 0x0A,
>> > +                       LINK_RATE_5_40GBPS = 0x14
>>
>> Same here. I'd rather see something like "link-rate-mbps" and use the
>> actual rate.
>
> There is no need whatsoever to hard-code this in DT. (e)DP provides the
> means to detect what rate the link supports and the specification
> provides guidance on how to select an appropriate one.

Good, even better.

Rob

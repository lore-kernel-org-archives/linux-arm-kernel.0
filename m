From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 2 Oct 2017 21:03:06 +0800
Subject: [PATCH v3 03/14] drm/sun4i: tcon: Add variant callback for TCON
 output muxing
In-Reply-To: <20170929101918.h7lfefk3bjj2lf74@flea>
References: <20170929082306.16193-1-wens@csie.org>
 <20170929082306.16193-4-wens@csie.org>
 <20170929101918.h7lfefk3bjj2lf74@flea>
Message-ID: <CAGb2v67V-5vxoa1H7FtOYO7kfnuiN+kXeCZEK=E-uLQkJR+wvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 6:19 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Sep 29, 2017 at 08:22:55AM +0000, Chen-Yu Tsai wrote:
>>  static const struct sun4i_tcon_quirks sun5i_a13_quirks = {
>> -     .has_unknown_mux = true,
>> -     .has_channel_1  = true,
>> +     .has_unknown_mux        = true,
>> +     .has_channel_1          = true,
>> +     .set_mux                = sun5i_a13_tcon_set_mux,
>
> I guess we could even retire has_unknown_mux now, since it provides
> the same information than if set_mux is set or to NULL.

I'll drop them in the same patch in v4.

ChenYu

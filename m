From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 Apr 2012 08:00:11 +0200
Subject: [GIT PULL] ux500 fixes for 3.4-rc series
In-Reply-To: <CAOesGMichoCWrUv0P6CMQw=nobwQPgHbsz0UD_Zjz1wQTsQg_Q@mail.gmail.com>
References: <CACRpkdbixRZb_6uT2M52zQ70Jb-uA0Lzhjy2ZG=g8vrKq9KPZg@mail.gmail.com>
 <CAOesGMichoCWrUv0P6CMQw=nobwQPgHbsz0UD_Zjz1wQTsQg_Q@mail.gmail.com>
Message-ID: <CACRpkdbOLqtAkr61Qp7_c-8w4NiyjOz3hVm5a8-8LtE-dxXqGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 6:29 AM, Olof Johansson <olof@lixom.net> wrote:

> In the future, there's no need to encode the date in the tag -- the
> tag itself contains the timestamp of when it was created/signed and
> you can just overwrite it with the same tag when you prepare fixes
> again next time (it's what we do).

Yeah I'll encode the v3.4-rcN or something more meaningful...
The use of unique tags is mostly a way to avoid conflicts
between identically named branches I have on my
local & remote gits.

Yours,
Linus Walleij

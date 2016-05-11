From: dianders@chromium.org (Doug Anderson)
Date: Wed, 11 May 2016 16:41:54 -0700
Subject: [PATCH v8 8/8] i2c: rk3x: support fast-mode plus for rk3399
In-Reply-To: <5153288.jNhUuzGC3g@phil>
References: <1462908252-27016-1-git-send-email-david.wu@rock-chips.com>
 <1462908794-27333-1-git-send-email-david.wu@rock-chips.com>
 <5153288.jNhUuzGC3g@phil>
Message-ID: <CAD=FV=VzQ8PRokgAaTV00L31mcXFEzBG8c1NB4+Rqyx75hwwDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Wed, May 11, 2016 at 2:09 PM, Heiko Stuebner <heiko@sntech.de> wrote:
> Additionally, the i2c-noob in me would wish for a short sentence on where
> the timing values come from (measured, somewhere in the TRM I didn't find or
> something completely different).

If you search for "UM10204" you'll find the first link is
<http://www.nxp.com/documents/user_manual/UM10204.pdf>.  That appears
to be the official standard.  At least that's what
<http://www.i2c-bus.org/fast-mode-plus/> says (though they have an old
link).

Agree that it wouldn't hurt to mention that in the commit message.

-Doug

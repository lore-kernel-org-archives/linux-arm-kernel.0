From: dianders@chromium.org (Doug Anderson)
Date: Thu, 5 May 2016 15:55:19 -0700
Subject: [PATCH v7 2/9] i2c: rk3x: use struct "rk3x_i2c_calced_timings"
In-Reply-To: <1462371194-5809-3-git-send-email-david.wu@rock-chips.com>
References: <1462371194-5809-1-git-send-email-david.wu@rock-chips.com>
 <1462371194-5809-3-git-send-email-david.wu@rock-chips.com>
Message-ID: <CAD=FV=WAbedAB78shifxwjmZ-od8rhOiNz80rpdqfwzRsdX6WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

On Wed, May 4, 2016 at 7:13 AM, David Wu <david.wu@rock-chips.com> wrote:
> Signed-off-by: David Wu <david.wu@rock-chips.com>

Usually folks like a description and not just a subject line.  I'd add
a description like:

The "div_high" and "div_low" values are always used together.  Group them
into a structure to make it easier to pass them both around.  This
structure also provides a place for future calculated timings.

> ---
> Change in v7:
> - none
>
>  drivers/i2c/busses/i2c-rk3x.c | 55 +++++++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 23 deletions(-)

Other than the description, I think this looks fine.

IMHO this can be applied any time independent of any earlier patches.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

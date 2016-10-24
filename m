From: dianders@chromium.org (Doug Anderson)
Date: Mon, 24 Oct 2016 11:29:54 -0700
Subject: [PATCH] i2c: rk3x: Give the tuning value 0 during
 rk3x_i2c_v0_calc_timings
In-Reply-To: <1477125822-30644-1-git-send-email-david.wu@rock-chips.com>
References: <1477125822-30644-1-git-send-email-david.wu@rock-chips.com>
Message-ID: <CAD=FV=VKJhaZtfT7CZBN1UE0-aHpJrMPYUDicO6vAcNUvfOP5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Oct 22, 2016 at 1:43 AM, David Wu <david.wu@rock-chips.com> wrote:
> We found a bug that i2c transfer sometimes failed on 3066a board with
> stabel-4.8, the con register would be updated by uninitialized tuning
> value, it made the i2c transfer failed.
>
> So give the tuning value to be zero during rk3x_i2c_v0_calc_timings.
>
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> ---
>  drivers/i2c/busses/i2c-rk3x.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

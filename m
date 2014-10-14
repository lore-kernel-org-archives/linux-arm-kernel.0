From: max.schwarz@online.de (Max Schwarz)
Date: Wed, 15 Oct 2014 00:42:21 +0200
Subject: [PATCH v6] i2c: rk3x: adjust the LOW divison based on
 characteristics of SCL
In-Reply-To: <1413266961-3859-1-git-send-email-addy.ke@rock-chips.com>
References: <1413168244-3553-1-git-send-email-addy.ke@rock-chips.com>
 <1413266961-3859-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <1801397.7yxIcDsLaN@typ>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Addy,

On Tuesday 14 October 2014 at 14:09:21, Addy Ke wrote:
> As show in I2C specification:
> - Standard-mode: the minimum HIGH period of the scl clock is 4.0us
>                  the minimum LOW period of the scl clock is 4.7us
> - Fast-mode: the minimum HIGH period of the scl clock is 0.6us
>              the minimum LOW period of the scl clock is 1.3us
> 
> I have measured i2c SCL waveforms in fast-mode by oscilloscope
> on rk3288-pinky board. the LOW period of the scl clock is 1.3us.
> It is so critical that we must adjust LOW division to increase
> the LOW period of the scl clock.
> 
> Thanks Doug for the suggestion about division formulas.
> 
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>

Reviewed-by: Max Schwarz <max.schwarz@online.de>
Tested-by: Max Schwarz <max.schwarz@online.de>

Cheers,
  Max

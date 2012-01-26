From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 26 Jan 2012 13:30:41 -0200
Subject: [PATCH v2] ARM: mx28: Let audio support be built by default
In-Reply-To: <1326739891-21529-1-git-send-email-fabio.estevam@freescale.com>
References: <1325169961-11923-1-git-send-email-festevam@gmail.com>
 <1326739891-21529-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <CAOMZO5DUORncyRF9cfijHFMY8BOfOi44zEeEzWhEhtf-nBQpkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 1/16/12, Fabio Estevam <fabio.estevam@freescale.com> wrote:
> Let audio support be built by default.
>
> As sgtl5000 codec is connected via I2C, let MXS I2C driver also be built
> by default.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Add regulator config options

Is this good now?

Regards,

Fabio Estevam

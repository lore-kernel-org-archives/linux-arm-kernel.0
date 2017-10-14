From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 13 Oct 2017 21:18:59 -0300
Subject: [PATCH 1/3] drm: bridge: synopsys/dw-hdmi: Enable cec clock
In-Reply-To: <20171013225337.5196-2-phh@phh.me>
References: <20171013225337.5196-1-phh@phh.me>
 <20171013225337.5196-2-phh@phh.me>
Message-ID: <CAOMZO5CtP=A0jF1FimScjSUvv-t6a2ua=ungr0LUHmQvUTKr3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pierre-Hugues,

On Fri, Oct 13, 2017 at 7:53 PM, Pierre-Hugues Husson <phh@phh.me> wrote:
> The documentation already mentions "cec" optional clock, but
> currently the driver doesn't enable it.

The cec clock is enabled at dw_hdmi_cec_enable().

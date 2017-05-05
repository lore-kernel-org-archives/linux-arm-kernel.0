From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 5 May 2017 08:48:36 -0300
Subject: [PATCH 1/5] ARM: dts: imx7-colibri: use OF graph to describe the
 display
In-Reply-To: <20170329232113.19078-1-stefan@agner.ch>
References: <20170329232113.19078-1-stefan@agner.ch>
Message-ID: <CAOMZO5Bp=K8_nP0_+MjQ9teS_U9SpRspOhVPwOwg1J0m0QZjCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Wed, Mar 29, 2017 at 8:21 PM, Stefan Agner <stefan@agner.ch> wrote:
> To make use of the new eLCDIF DRM driver OF graph description is
> required. Describe the display using OF graph nodes.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Could you please confirm that drm/mxsfb is working fine on 4.11 on your board?

I am converting mx6sx sdb to use drm/mxsfb and I noticed that when
board boots I get garbage on the display.

If I do a blank/unblank then things are displayed correctly.

Thanks

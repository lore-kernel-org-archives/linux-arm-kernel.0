From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 5 May 2017 10:18:42 -0300
Subject: [PATCH 1/5] ARM: dts: imx7-colibri: use OF graph to describe the
 display
In-Reply-To: <CAOMZO5Bp=K8_nP0_+MjQ9teS_U9SpRspOhVPwOwg1J0m0QZjCg@mail.gmail.com>
References: <20170329232113.19078-1-stefan@agner.ch>
 <CAOMZO5Bp=K8_nP0_+MjQ9teS_U9SpRspOhVPwOwg1J0m0QZjCg@mail.gmail.com>
Message-ID: <CAOMZO5AuvgqtNTHUW-LyXy9Xsq=rnaPODBzWA3FRmRpxqrRqAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 5, 2017 at 8:48 AM, Fabio Estevam <festevam@gmail.com> wrote:

> Could you please confirm that drm/mxsfb is working fine on 4.11 on your board?
>
> I am converting mx6sx sdb to use drm/mxsfb and I noticed that when
> board boots I get garbage on the display.
>
> If I do a blank/unblank then things are displayed correctly.

Ok, I managed to fix the drm/mxsfb driver.

Will submit a patch shortly.

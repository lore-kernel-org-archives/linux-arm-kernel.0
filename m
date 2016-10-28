From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 28 Oct 2016 09:34:16 -0200
Subject: [PATCH 1/1] ARM: dts: imx6ul-14x14-evk: add USB dual-role support
In-Reply-To: <1470128903-942-1-git-send-email-peter.chen@nxp.com>
References: <1470128903-942-1-git-send-email-peter.chen@nxp.com>
Message-ID: <CAOMZO5Ddw7xg1hrDRtHnP3_fLE+bFcxMeQ=AByejE5HE=RH6wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 2, 2016 at 6:08 AM, Peter Chen <peter.chen@nxp.com> wrote:
> With commit 851ce932242d ("usb: chipidea: otg: don't wait vbus
> drops below BSV when starts host"), the driver can support
> enabling vbus output without software control, so this board
> (control vbus output through ID pin) can support dual-role now.
>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

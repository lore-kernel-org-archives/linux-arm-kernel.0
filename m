From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 5 Dec 2017 12:12:10 -0200
Subject: [PATCH v2 3/5] rtc: mxc_v2: add driver for i.MX53 SRTC
In-Reply-To: <20171205140646.30367-4-linux-kernel-dev@beckhoff.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-4-linux-kernel-dev@beckhoff.com>
Message-ID: <CAOMZO5DkHM4L17eHQVANhtrkQkP8ayvVtXD9aVu==5CnauJqeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 12:06 PM,  <linux-kernel-dev@beckhoff.com> wrote:
> From: Patrick Bruenn <p.bruenn@beckhoff.com>
>
> Add RTC_DRV_MXC_V2 config option
>
> Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>

You should add the Kconfig as part of the patch that introduces the driver.

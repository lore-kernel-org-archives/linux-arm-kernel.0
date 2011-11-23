From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 23 Nov 2011 11:05:00 -0200
Subject: BUG: sleeping function called from invalid context
In-Reply-To: <CAOMZO5DSvLU0ACJPZ69tzY0PjMijibSzwCEwBhu=5=mg7ncF=g@mail.gmail.com>
References: <4ECCDAA2.4070502@prolan.hu>
 <CAOMZO5DSvLU0ACJPZ69tzY0PjMijibSzwCEwBhu=5=mg7ncF=g@mail.gmail.com>
Message-ID: <CAOMZO5A1dfkG9UOE6MqBFKG6LV=T8G0-SWedNbhErhAZiEm83A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 10:44 AM, Fabio Estevam <festevam@gmail.com> wrote:

> Looks like the same error I faced before:
> http://marc.info/?l=linux-arm-kernel&m=131914543319956&w=2

Also, can you please try Sascha's imx-features branch?
http://git.pengutronix.de/?p=imx/linux-2.6.git;a=shortlog;h=refs/heads/imx-features

It contains a patch series from Richard Zhao that introduces
clk_prepare that may possibly help with this issue.

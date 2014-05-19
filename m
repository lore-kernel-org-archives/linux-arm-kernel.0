From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 19 May 2014 10:18:36 +0100
Subject: [PATCH 7/7] ARM: tegra: Add the EC i2c tunnel to tegra124-venice2
In-Reply-To: <CAOesGMhe-STC3GUwAyC6qeEPWWmxdsWbXqdevy8b4MHDgM2v=A@mail.gmail.com>
References: <1397757570-19750-1-git-send-email-dianders@chromium.org>
 <1397757570-19750-8-git-send-email-dianders@chromium.org>
 <53750A9A.8000808@wwwdotorg.org>
 <CAD=FV=Vj5M_yiYZOkjzB-QjYJa9WE2fcGcwwzAF1h8gcjc9jeA@mail.gmail.com>
 <CAOesGMhe-STC3GUwAyC6qeEPWWmxdsWbXqdevy8b4MHDgM2v=A@mail.gmail.com>
Message-ID: <20140519091836.GD4978@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 May 2014, Olof Johansson wrote:

> On Thu, May 15, 2014 at 11:55 AM, Doug Anderson <dianders@chromium.org> wrote:
> > Stephen,
> >
> > On Thu, May 15, 2014 at 11:42 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >> On 04/17/2014 11:59 AM, Doug Anderson wrote:
> >>> This adds the EC i2c tunnel (and devices under it) to the
> >>> tegra124-venice2 device tree.
> >>
> >> Did the MFD patches at the start of this series get applied yet? I was
> >> hoping to apply this one patch to the Tegra tree for 3.16, and that
> >> needs to happen by tomorrow morning at the latest since -rc6 is looming
> >> fast. However, I'm holding off until the rest of the series is applied
> >> to the MFD tree so I can be sure the DT binding is accepted first...
> >
> > As far as I know, they didn't.  Lee was waiting on Wolfram's ack to
> > the i2c tunnel before landing them.  ...and I'm still eagerly awaiting
> > Wolfram's next i2c tunnel review.
> 
> The i2c portion can be revisited if needed, the MFD piece should be
> possible to land sooner than that... Lee?

The set 'will' make it in during this cycle.  The trouble is, once
it's applied, the I2C portion will have to wait until the next cycle.
By applying late, I'm giving this set every chance to go in as a
whole.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

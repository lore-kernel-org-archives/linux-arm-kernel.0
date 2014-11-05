From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Nov 2014 15:12:58 +0800
Subject: [GIT PULL] ARM: imx: fixes for 3.18, 2nd round
In-Reply-To: <CAOesGMgCDNcee5-_tTkvkt4JQ29v30U9cCk0Pf25KMpAuVTfEQ@mail.gmail.com>
References: <20141104112026.GL10821@tiger>
 <CAOesGMgCDNcee5-_tTkvkt4JQ29v30U9cCk0Pf25KMpAuVTfEQ@mail.gmail.com>
Message-ID: <20141105071257.GD21210@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 08:39:57PM -0800, Olof Johansson wrote:
> On Tue, Nov 4, 2014 at 3:20 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > Hi Arnd, Olof,
> >
> > This is the second round of i.MX fixes for 3.18.  The clk-vf610 fix is
> > relatively big, because it needs some adaption to the change made by
> > offending commit dc4805c2e78b (ARM: imx: remove ENABLE and BYPASS bits
> > from clk-pllv3 driver).  And it should have been sent to you for earlier
> > -rc inclusion, but unfortunately it got delayed for some time because
> > Stefan wasn't aware of my email address change.
> >
> > Please consider to send them for 3.18 inclusion.  Thanks.
> 
> In the future, feel free to look at our tree when you prepare fixes
> and see where our branch is currently at (based on -rc2). If there's
> no reason to bring in a newer -rc for your fixes, then keeping your
> branch at the same version as ours makes it just slightly tidier here
> at our end.

Okay, noted.

Shawn

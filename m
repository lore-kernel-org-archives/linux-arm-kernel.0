From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Jan 2012 14:17:50 +0800
Subject: [PATCH v2] ARM: mx28: Let audio support be built by default
In-Reply-To: <CAOMZO5DUORncyRF9cfijHFMY8BOfOi44zEeEzWhEhtf-nBQpkw@mail.gmail.com>
References: <1325169961-11923-1-git-send-email-festevam@gmail.com>
 <1326739891-21529-1-git-send-email-fabio.estevam@freescale.com>
 <CAOMZO5DUORncyRF9cfijHFMY8BOfOi44zEeEzWhEhtf-nBQpkw@mail.gmail.com>
Message-ID: <20120127061748.GA32740@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 01:30:41PM -0200, Fabio Estevam wrote:
> Hi Shawn,
> 
> On 1/16/12, Fabio Estevam <fabio.estevam@freescale.com> wrote:
> > Let audio support be built by default.
> >
> > As sgtl5000 codec is connected via I2C, let MXS I2C driver also be built
> > by default.
> >
> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> > ---
> > Changes since v1:
> > - Add regulator config options
> 
> Is this good now?
> 
Yes.  Applied, thanks.

-- 
Regards,
Shawn

From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Tue, 28 Apr 2015 11:30:58 +0300
Subject: [PATCH 01/11] coresight-etm4x: Adding CoreSight ETM4x driver
In-Reply-To: <CANLsYky6TZhZ=JZuoBxU4dNRWVPYGUj6joMfi+dD9zjaokRE0A@mail.gmail.com>
References: <1429742451-11465-1-git-send-email-mathieu.poirier@linaro.org>
 <1429742451-11465-2-git-send-email-mathieu.poirier@linaro.org>
 <1429890108.5211.8.camel@mm-sol.com>
 <CANLsYky6TZhZ=JZuoBxU4dNRWVPYGUj6joMfi+dD9zjaokRE0A@mail.gmail.com>
Message-ID: <1430209858.1904.1.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, 2015-04-27 at 09:48 -0600, Mathieu Poirier wrote:
> On 24 April 2015 at 09:41, Ivan T. Ivanov <iivanov@mm-sol.com> wrote:
> > On Wed, 2015-04-22 at 16:40 -0600, Mathieu Poirier wrote:
> > 
> > > +static struct amba_id etm4_ids[] = {
> > > +       {       /* ETM 4.0 - Hi6220 board */
> > > +               .id     = 0x0003b95d,
> > > +               .mask   = 0x0003ffff,
> > > +               .data   = "ETM 4.0",
> > > +       },
> > > +       {       /* ETM 4.0 - Juno board */
> > > +               .id     = 0x000bb95e,
> > > +               .mask   = 0x000bffff,
> > 
> > Mask looks suspicious.
> 
> Can you please expand the "suspicious" part ?

Well, 'b' part of the mask. I have to admit that
I don't know how this is mapped on this platform.

Regards,
Ivan

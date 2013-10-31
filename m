From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Oct 2013 21:00:53 +0000
Subject: [PATCH v4] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <CAOMZO5C39JNVv0vz-38eOrKHXMqWHCeCknhSvfGFe5t0EGkDsg@mail.gmail.com>
References: <1383181127-12013-1-git-send-email-festevam@gmail.com>
 <5272BC59.1080109@boundarydevices.com> <5272BFE0.5040409@boundarydevices.com>
 <CAOMZO5C39JNVv0vz-38eOrKHXMqWHCeCknhSvfGFe5t0EGkDsg@mail.gmail.com>
Message-ID: <20131031210053.GH16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 06:45:41PM -0200, Fabio Estevam wrote:
> Hi Troy,
> 
> On Thu, Oct 31, 2013 at 6:38 PM, Troy Kisky
> <troy.kisky@boundarydevices.com> wrote:
> 
> >> I get a magenta line down the left side of the screen unless I replace the
> >> 5 with a 6.
> >> ie.
> >>
> >> +    for (count = 0; count < 6; count++)
> >> +        hdmi_writeb(hdmi, val, HDMI_FC_INVIDCONF);
> >>
> >>
> >> This is with a imx6q processor. With the 6, the picture looks great!
> >>
> >> Troy
> >>
> >
> > It also works if I change the 5 to a 4! A 3 fails though.
> > To summarize:
> > 0 works
> > 1 fails
> > 2 works
> > 3 fails
> > 4 works
> > 5 fails
> > 6 works
> > Very strange.
> 
> Interesting. With the monitor I have tested I am not able to see this
> magenta line.

Monitor or TV?  Beware of overscans which will hide this effect.

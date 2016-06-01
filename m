From: horms@verge.net.au (Simon Horman)
Date: Wed, 1 Jun 2016 17:32:26 +0900
Subject: [RFC 0/4] ARM: dts: r8a7790: lager: use demuxer for I2C
In-Reply-To: <CANqRtoTRRNQGk-gy1NrQhXNB0fzvkHDxwJGxyQHTYAgHUXm9ZA@mail.gmail.com>
References: <1464665528-11398-1-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoTRRNQGk-gy1NrQhXNB0fzvkHDxwJGxyQHTYAgHUXm9ZA@mail.gmail.com>
Message-ID: <20160601083226.GA4163@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2016 at 12:17:29PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Tue, May 31, 2016 at 12:32 PM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > the intention of this series is to extend use of the demuxer for I2C
> > on the lager/r8a7790 to cover all I2C IP blocks.
> >
> > This is based on work by Wolfram Sang.
> >
> > I have not included GPIO in the demux configuration. This is in keeping
> > with the existing usage for IIC0/I2C0.
> 
> Thanks for your efforts! Can you please include GPIO support in next
> version? This way we should in the future be able to use
> distro-kernels out of the box that may only have GPIO bitbang support
> enabled.

Sure, will do.

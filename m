From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 20 Aug 2015 17:06:46 +0800
Subject: [GIT PULL 1/3] ARM: imx: soc updates for 4.3
In-Reply-To: <20150818201416.GA4732@localhost>
References: <1439311351-5268-1-git-send-email-shawnguo@kernel.org>
 <20150818201416.GA4732@localhost>
Message-ID: <20150820090646.GB9137@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 18, 2015 at 01:14:16PM -0700, Olof Johansson wrote:
> Hi,
> 
> On Wed, Aug 12, 2015 at 12:42:29AM +0800, Shawn Guo wrote:
> > Hi arm-soc maintainers,
> > 
> > This is the i.MX SoC changes for 4.3.  There are some input and rtc
> > changes, because they are applied as a series.  Subsystem maintainers
> > have ACKed these changes, so it should be fine to send them via arm-soc
> > tree.
> 
> In some of these cases, may I ask why? For example, the RTC changes look
> like they could just go in through the driver tree -- adding DT support to
> a driver can definitely do so (and the DT changes to plumb up the device can go
> through your DT branch).

It's primarily because that subsystem maintainers gave their ACKs and
asked me to apply the series as a whole.  I will pick up subsystem
patches only when it's necessary in the future.

Shawn

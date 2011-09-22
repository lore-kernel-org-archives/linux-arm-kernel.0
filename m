From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Sep 2011 17:28:08 +0200
Subject: [PATCH] i2c/tegra: I2C driver uses the suspend_noirq/resume_noirq
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B73215C9@HQMAIL01.nvidia.com>
References: <1312586102-27907-1-git-send-email-swarren@nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B3279D4F@HQMAIL01.nvidia.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B73215C9@HQMAIL01.nvidia.com>
Message-ID: <201109221728.09063.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 September 2011, Stephen Warren wrote:
> Stephen Warren wrote at Tuesday, August 30, 2011 10:25 AM:
> > Ben, Arnd,
> > 
> > Could you please ack/nack the patch at the start of this thread for Colin;
> > see below.
> 
> Ben, can you please comment on the acceptability of this patch?
> 
> Or Arnd, did Mark's most recent explanation of the situation provide enough
> context for you to ack/nak it?
> 

After looking through the discussion again, my feeling is that it's ok
and I think that Mark's word should count more than mine anyway on this
issue.

If you think it helps, you can add my Acked-by, but this is really
something for Ben to decide. Just resubmit the patch to Ben with an
an updated changelog that summarises the discussion, in case
Ben got bored already and put this mail thread into the ignore
folder...

	Arnd

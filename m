From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 1 Jun 2011 19:02:35 +0200
Subject: [PATCH] arm: fix regression in ixp4xx clocksource
In-Reply-To: <m3d3ixtwqc.fsf@intrepid.localdomain>
References: <20110530084307.GA28953@riccoc20.at.omicron.at>
	<m3d3ixtwqc.fsf@intrepid.localdomain>
Message-ID: <20110601170235.GB20696@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 01, 2011 at 05:08:59PM +0200, Krzysztof Halasa wrote:
> Richard Cochran <richardcochran@gmail.com> writes:
> 
> > Commit 234b6ceddb4fc2a4bc5b9a7670f070f6e69e0868
> >
> >    clocksource: convert ARM 32-bit up counting clocksources
> >
> > broke the build for ixp4xx and made big endian operation impossible.
> > This commit restores the original behaviour.
> 
> Thanks.
> 
> I can't ATM do anything Linux-related but will do ASAP. Two-three weeks
> I hope.

I don't complain that you have a lack of time for this issue. Still,
it is a serious bug for IXP, and it should be fixed in the 3.0
release.

Russell, can you please, please take a look?

Thanks,
Richard

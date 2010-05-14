From: jeff@garzik.org (Jeff Garzik)
Date: Fri, 14 May 2010 17:48:44 -0400
Subject: [BUG] bug when enabling VM DEBUG
In-Reply-To: <1273750233.30713.39.camel@e102109-lin.cambridge.arm.com>
References: <AANLkTikkSRI6u_mp6mNQReECB84t3oh-_MPVzAYEQULN@mail.gmail.com>	
	<AANLkTikoNc6oAY5JthYX1jWx1w2KeJ1fGab72Z-OvIVG@mail.gmail.com>	
	<4BEA1559.9000107@gmail.com>	
	<1273662639.23818.67.camel@e102109-lin.cambridge.arm.com>	
	<20100512115340.GA11261@Chamillionaire.breakpoint.cc>	
	<1273667099.23818.86.camel@e102109-lin.cambridge.arm.com>	
	<20100512130638.GB19314@shareable.org>
	<1273750233.30713.39.camel@e102109-lin.cambridge.arm.com>
Message-ID: <4BEDC53C.8040107@garzik.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2010 07:30 AM, Catalin Marinas wrote:
> I already proposed a PIO cache flushing API on linux-arch. I tried to
> revive the discussion with another patch for cachetlb.txt but it hasn't
> drawn much interest.


Oh well.  I'll apply the local-to-libata patch, and hope that someone 
else proposes a better API.

	Jeff

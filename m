From: ben-linux@fluff.org (Ben Dooks)
Date: Sun, 1 Nov 2009 00:48:54 +0000
Subject: Possible suspend/resume regression in .32-rc?
In-Reply-To: <87r5sjwm9n.fsf@free.fr>
References: <20091031013427.GL14091@buzzloop.caiaq.de> <87r5sjwm9n.fsf@free.fr>
Message-ID: <20091101004853.GG8096@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 31, 2009 at 05:39:32PM +0100, Robert Jarzmik wrote:
> Daniel Mack <daniel@caiaq.de> writes:
> 
> > Does anyone use that successfully? Any idea for possible regressions?
> The issue seems confirmed. My mioa701 phone doesn't resume either, with
> 2.6.32-rc5 kernel.

Works with several S3C24XX based machines, so it doesn't seem to be a
core problem.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

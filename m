From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 23 Jan 2013 22:45:54 +0000
Subject: [GIT PULL] psci client-side implementation for 3.9
In-Reply-To: <20130123180507.GH26811@mudshark.cambridge.arm.com>
References: <20130123180507.GH26811@mudshark.cambridge.arm.com>
Message-ID: <20130123224554.GT23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 06:05:07PM +0000, Will Deacon wrote:
> Hello again guys,
> 
> Please pull my PSCI client-side implementation for 3.9. This is used by
> the mach-virt platform, for which I'll send another pull request later
> on (since there are some timer dependencies that need resolving first).
> 
> As before, I'll keep this branch stable so others can base against it.

Ok, pulled all four, but I'm going to delay a day before pushing the
tree out - I'd like to let the overnight build system chew on this for
one night.

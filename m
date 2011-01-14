From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Jan 2011 18:04:55 +0000
Subject: [GIT PULL] AT91: patches for v2.6.38-rc1
In-Reply-To: <4D308F30.6070503@atmel.com>
References: <4D308F30.6070503@atmel.com>
Message-ID: <20110114180455.GL15996@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 07:00:16PM +0100, Nicolas Ferre wrote:
> Hi Russell,
> 
> Can you please pull those little changes for AT91? They add two 
> new boards already discussed on the mailing list and a little 
> cleanup patch:

Has this already been in linux-next?

We should only be merging new code during a merge window which has
already had visibility in linux-next, with the exception of bug fixes
and regression fixes.

Regression fixes can be merged at any time provided they're obvious.
Any regression fix should be acceptable during the merge window.

Bug fixes any time up until (I'd say) the last week of the -rc series.

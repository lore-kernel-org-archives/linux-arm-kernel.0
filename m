From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 5 Jan 2010 19:08:05 +0000
Subject: [PATCH 3/5] arm: use the spinlocked, generic atomic64 support
In-Reply-To: <20100105185732.GF14376@shareable.org>
References: <1262602122-10373-1-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-2-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-3-git-send-email-jamie.iles@picochip.com>
	<1262602122-10373-4-git-send-email-jamie.iles@picochip.com>
	<20100105185732.GF14376@shareable.org>
Message-ID: <20100105190805.GJ4179@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2010 at 06:57:32PM +0000, Jamie Lokier wrote:
> Jamie Iles wrote:
> > perf events require that we can support atomic64's. There is a generic,
> > spinlocked version that we can use until we have proper hardware
> > support.
> 
> Is that simply waiting for LDREXD/STREXD-based atomic64's, or is it
> depending on something subtler?
Yes, Will Deacon submitted a patch last month that does this but afaik it
hasn't been merged in yet.

Jamie

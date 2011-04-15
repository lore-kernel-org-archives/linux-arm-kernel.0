From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Apr 2011 16:41:13 +0100
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <BANLkTinDwH9G1zW784t=QnNR7kZkgfKA8w@mail.gmail.com>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<4DA84AAB.60601@gmail.com> <201104151640.01040.arnd@arndb.de>
	<20110415152643.GC4423@n2100.arm.linux.org.uk>
	<BANLkTinDwH9G1zW784t=QnNR7kZkgfKA8w@mail.gmail.com>
Message-ID: <20110415154113.GE4423@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 09:32:01AM -0600, Grant Likely wrote:
> Yes, once the infrastructure is in place, powerpc can do its own
> migration to the new code.  I vote for putting it in lib at the
> outset.

I don't agree with stuffing non-arch directories with code which people
haven't already agreed should be shared.  As I've already said, in my
experience it's hard to get agreement in the first place and even when
you can the API generally needs to be changed from what you first think
would be reasonable.

So, lets wait to see whether the SH folk reply.

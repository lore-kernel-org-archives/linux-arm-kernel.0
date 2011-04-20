From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Apr 2011 09:43:26 +0200
Subject: Status of arch/arm in linux-next
In-Reply-To: <20110420073313.GB28679@atomide.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<201104191616.01647.arnd@arndb.de>
	<20110420073313.GB28679@atomide.com>
Message-ID: <201104200943.26284.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 April 2011 09:33:13 Tony Lindgren wrote:
> For omaps we have the hwmod bus abstraction for platform bus that could
> be made generic potentially. Needs to be converted to use DT data first
> though..

Yes, we had some discussions during ELC about how the data in hwmod can
be put into DT format. I learned that the files are currently
semi-automatically generated from the hardware specifications, and I've
got a good feeling about being able to generate DT fragments in the
same way.

	Arnd

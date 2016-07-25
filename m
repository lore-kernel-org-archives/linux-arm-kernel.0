From: geoff@infradead.org (Geoff Levand)
Date: Mon, 25 Jul 2016 14:56:01 -0700
Subject: [PATCH v1 3/4] arm64: Add arm64 kexec support
In-Reply-To: <5791EF62.5070006@arm.com>
References: <cover.1468970114.git.geoff@infradead.org>
 <9ed513fd44a19b2f49b4da99477cedfff7341bf0.1468970114.git.geoff@infradead.org>
 <20160720153859.GG24691@leverpostej>
 <1469042361.2977.90.camel@infradead.org>
 <20160721103120.GB20559@leverpostej> <5790A902.6070601@arm.com>
 <1469137776.2977.128.camel@infradead.org>
 <20160722040842.GA14911@localhost.localdomain> <5791EF62.5070006@arm.com>
Message-ID: <1469483761.2889.10.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-07-22 at 11:03 +0100, Robin Murphy wrote:

> I suggest we simply copy the purgatory
> console
> implementation from, say, ARM or Alpha.

I decided on what mips had.  It was a little more applicable.

I put the code I removed into a separate patch, 'arm64: Add
purgatory printing' that we can use to build the perfect bike
shed later.

-Geoff

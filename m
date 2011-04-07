From: khilman@ti.com (Kevin Hilman)
Date: Thu, 07 Apr 2011 10:08:41 -0700
Subject: [PATCH/RFC 4/6] ARM: move SH-mobile runtime PM to arm/common for
	sharing with other platforms
In-Reply-To: <20110407165654.GD8052@linux-sh.org> (Paul Mundt's message of
	"Fri, 8 Apr 2011 01:56:54 +0900")
References: <1302134569-22825-1-git-send-email-khilman@ti.com>
	<1302134569-22825-5-git-send-email-khilman@ti.com>
	<20110407165654.GD8052@linux-sh.org>
Message-ID: <8739lu9eg6.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paul Mundt <lethal@linux-sh.org> writes:

> On Wed, Apr 06, 2011 at 05:02:47PM -0700, Kevin Hilman wrote:
>> There is really nothing SH-mobile specific about this runtime PM
>> implementation.  Any platform wanting to implement runtime PM based on
>> simple clock gating can use this implementation.
>> 
>> Signed-off-by: Kevin Hilman <khilman@ti.com>
>
> This observation is wholly architecture agnostic, so it's not clear that
> keeping it in arch/arm/common is any better. It seems that this would be
> better suited for drivers/base/power/ with a generic Kconfig symbol.

Sounds fine to me.

Thanks for the review,

Kevin

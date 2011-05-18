From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 18 May 2011 13:06:01 +0100
Subject: [PATCH] arm: Add Cortex A5 proc_info
In-Reply-To: <20110518105308.GA2544@arm.com>
References: <1305650956-20997-1-git-send-email-pawel.moll@arm.com>
	<1305712038.17656.41.camel@hornet.cambridge.arm.com>
	<20110518105308.GA2544@arm.com>
Message-ID: <1305720361.17656.44.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The simplest solution might be to use a macro to avoid duplication in
> the source.  This would still create diffstat noise, but it's not
> actually fragmentary, so it may be considered OK.

Yeah, I like this idea. Macro would do here probably, especially that it
could be used in future by A15 proc_info as well. Will give it a try.

Cheers!

Pawe?

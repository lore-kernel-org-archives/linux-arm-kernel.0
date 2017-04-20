From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 20 Apr 2017 13:45:19 +0100
Subject: [RFC PATCH v2 0/6] Signal frame expansion support
In-Reply-To: <8760hz47u7.fsf@concordia.ellerman.id.au>
References: <1492016239-19511-1-git-send-email-Dave.Martin@arm.com>
 <8760hz47u7.fsf@concordia.ellerman.id.au>
Message-ID: <20170420124516.GQ3750@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 09:49:36PM +1000, Michael Ellerman wrote:
> Dave Martin <Dave.Martin@arm.com> writes:
> 
> > (Note: This is an arm64-specific series, but the concepts introduced may
> > be of interest to other arches -- see in particular patch 6.)
> 
> Hi Dave,
> 
> I think we (powerpc) will probably want to use this too.
> 
> I haven't dug into the details yet, I'll try and do that after the 4.12
> merge window.

That would be great, thanks.

Since I've been focusing on arm64 and SVE, there may be generalities
or design issues that I've missed.

Cheers
---Dave

From: joe@perches.com (Joe Perches)
Date: Tue, 18 Oct 2011 17:14:08 -0700
Subject: [PATCH 0/3] ARM 4Kstacks: introduction
In-Reply-To: <4E9E0B71.9020708@am.sony.com>
References: <4E9E0B71.9020708@am.sony.com>
Message-ID: <1318983248.7569.5.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-10-18 at 16:27 -0700, Tim Bird wrote:
> I'm about to submit a set of patches (really pretty small)
> to add 4K stack support to ARM (defaulted to 'N').

When 4k stacks went away, I thought it safe enough
to submit vsnprintf recursion using %pV.

I believe the current vsnprintf max recursion is 3.
Each recursion uses at least 300 bytes of stack.

That might be some additional issue for 4k stacks.

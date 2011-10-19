From: joe@perches.com (Joe Perches)
Date: Tue, 18 Oct 2011 17:31:41 -0700
Subject: [PATCH 0/3] ARM 4Kstacks: introduction
In-Reply-To: <4E9E1944.80601@am.sony.com>
References: <4E9E0B71.9020708@am.sony.com>
	<1318983248.7569.5.camel@Joe-Laptop> <4E9E1944.80601@am.sony.com>
Message-ID: <1318984301.7569.9.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-10-18 at 17:26 -0700, Tim Bird wrote:
> On 10/18/2011 05:14 PM, Joe Perches wrote:
> > On Tue, 2011-10-18 at 16:27 -0700, Tim Bird wrote:
> >> I'm about to submit a set of patches (really pretty small)
> >> to add 4K stack support to ARM (defaulted to 'N').
> > When 4k stacks went away, I thought it safe enough
> > to submit vsnprintf recursion using %pV.
> Even inside Sony, usage of 4K stacks is limited
> to some very special cases, where memory is exceedingly
> tight (we have one system with 4M of RAM).  And we
> don't mind lopping off features or coding around
> problem areas to support our special case.

I believe CONFIG_PRINTK=n assures no %pV problem.

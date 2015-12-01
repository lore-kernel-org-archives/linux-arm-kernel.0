From: mmarek@suse.cz (Michal Marek)
Date: Tue, 1 Dec 2015 22:39:06 +0100
Subject: [PATCH v2 1/2] scripts: Add a recorduidiv program
In-Reply-To: <20151201181643.GZ8644@n2100.arm.linux.org.uk>
References: <1448488264-23400-2-git-send-email-sboyd@codeaurora.org>
 <20151125234711.GT8644@n2100.arm.linux.org.uk> <565C6714.802@suse.com>
 <20151130153208.GR8644@n2100.arm.linux.org.uk> <565C6DE9.2020302@suse.com>
 <565DC5A9.2010305@suse.cz> <20151201161944.GX8644@n2100.arm.linux.org.uk>
 <20151201114929.655433a2@gandalf.local.home>
 <20151201171014.GY8644@n2100.arm.linux.org.uk>
 <20151201122212.474afce5@gandalf.local.home>
 <20151201181643.GZ8644@n2100.arm.linux.org.uk>
Message-ID: <565E137A.2020106@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne 1.12.2015 v 19:16 Russell King - ARM Linux napsal(a):
> On Tue, Dec 01, 2015 at 12:22:12PM -0500, Steven Rostedt wrote:
>> I guess another solution is to do a copy instead of modifying in place
>> if it detects the multiple hard link?
> 
> That would be the "transparent" solution.  If you think it's worth
> persuing, I'll have a go at fixing recordmcount to do that.

But in terms of number of file copies, it would on par with disabling
CCACHE_HARDLINK from within the Makefile.

Michal

From: lethal@linux-sh.org (Paul Mundt)
Date: Mon, 11 Oct 2010 20:09:25 +0900
Subject: [PATCH 7/7] sh: oprofile: Use perf-events oprofile backend
In-Reply-To: <20101011110654.GR13563@erda.amd.com>
References: <cover.1286584677.git.matt@console-pimps.org>
	<a0c83396f5fb8a29baff3daf43d29b2e601511ff.1286584677.git.matt@console-pimps.org>
	<20101011110654.GR13563@erda.amd.com>
Message-ID: <20101011110925.GB1155@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 01:06:54PM +0200, Robert Richter wrote:
> Matt and Paul,
> 
> are those (upper case) cpu_type strings already supported by the
> oprofile userland?
> 
I've only ever used out-of-tree patches with it due to the generally
volatile nature of support. Now that we have a more consistent interface
to go through, it probably makes sense to get those bits merged, too.
We're certainly not tied down to any ABI at this point.

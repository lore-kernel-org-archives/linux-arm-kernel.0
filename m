From: tim.bird@am.sony.com (Tim Bird)
Date: Thu, 5 May 2011 11:03:21 -0700
Subject: [RFC PATCH] arm: drop Execute-In-Place
In-Reply-To: <4DC2E5AA.5010604@am.sony.com>
References: <1304607121-13612-1-git-send-email-plagnioj@jcrosoft.com>
	<4DC2E5AA.5010604@am.sony.com>
Message-ID: <4DC2E669.2000101@am.sony.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2011 11:00 AM, Tim Bird wrote:
> On 05/05/2011 07:52 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> nearly no-one use it, only amop1, pxa and sa1100 implement it
> 
> Sony uses this - a lot.  Principally we're using this on a NEC
> naviengine part, which is ARM11MPCore based, support for which
> is (sadly) out of tree.
> 
> I'd like to see MORE support for XIP in the kernel, not less.
> 
> NAK from me.

By the way - it would be good to copy linux-embedded on this,
to expand the discussion.

I should have done that in my response, but I'm doing so now.
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Workgroup of the Linux Foundation
Senior Staff Engineer, Sony Network Entertainment
=============================

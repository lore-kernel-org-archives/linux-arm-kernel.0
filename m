From: dwmw2@infradead.org (David Woodhouse)
Date: Thu, 05 May 2011 19:32:24 +0100
Subject: [RFC PATCH] arm: drop Execute-In-Place
In-Reply-To: <4DC2E669.2000101@am.sony.com>
References: <1304607121-13612-1-git-send-email-plagnioj@jcrosoft.com>
	<4DC2E5AA.5010604@am.sony.com> <4DC2E669.2000101@am.sony.com>
Message-ID: <1304620350.2398.29.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-05 at 11:03 -0700, Tim Bird wrote:
> On 05/05/2011 11:00 AM, Tim Bird wrote:
> > On 05/05/2011 07:52 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >> nearly no-one use it, only amop1, pxa and sa1100 implement it
> > 
> > Sony uses this - a lot.  Principally we're using this on a NEC
> > naviengine part, which is ARM11MPCore based, support for which
> > is (sadly) out of tree. 

If you're out of tree, you don't exist.

-- 
dwmw2

From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 9 May 2013 09:22:36 +0100
Subject: [RFC PATCH v2 08/11] ARM64: mm: Swap PTE_FILE and
 PTE_PROT_NONE bits.
In-Reply-To: <20130508164018.GF20820@mudshark.cambridge.arm.com>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-9-git-send-email-steve.capper@linaro.org>
 <20130508164018.GF20820@mudshark.cambridge.arm.com>
Message-ID: <20130509082235.GB28545@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 05:40:19PM +0100, Will Deacon wrote:
> On Wed, May 08, 2013 at 10:52:40AM +0100, Steve Capper wrote:

 [...] 

> Can you update the comment describing swp entries too please? I *think* the
> __SWP_* defines can remain untouched, but the comment is now wrong.
> 
> Will

Ta Will, I've now changed the other comment.
The __SWP_* entries look ok to me. I'm going to run some swap tests though
to see if anything crops up.

Cheers,
-- 
Steve

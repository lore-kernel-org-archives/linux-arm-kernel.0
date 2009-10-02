From: davidb@quicinc.com (David Brown)
Date: Fri, 2 Oct 2009 16:50:05 -0700
Subject: 3rd party patches?
Message-ID: <20091002235005.GA31813@huya.quicinc.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, is there a way to submit patches to your patch system
that will set the author field to a third party?  I submitted
with the initial From: line that git format-patch generated, but
that didn't seem to work.  There's probably going to be a handful
of patches we're pushing where the author will be someone other
than the one sending the email.

Thanks,
David Brown

commit 31abdb744179159f8b605f56da5b197b188e1689
Author: David Brown <davidb@codeaurora.org>
Date:   Thu Oct 1 17:43:29 2009 +0100

    ARM: 5739/1: ARM: allow empty ATAG_CORE
    
    From: David Brown <davidb@quicinc.com>
    
    The ATAG_CORE is allowed to be empty.  Although this is handled
    by parse_tag_core(), __vet_atags during startup rejects this tag
    unless it contains data.  Allow the initial tag to be either the
    full size, or empty.
    
    Signed-off-by: David Brown <davidb@quicinc.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

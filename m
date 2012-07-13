From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri, 13 Jul 2012 11:01:45 -0700
Subject: [RFc] Map CMA pages as cached
Message-ID: <1342202506-12449-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current APIs only support allocating CMA pages as either coherent or
writecombine. This seems to miss support for cached pages completely.
The following patch seems to be the first obvious solution.

More generally though, what should be the strategy for remapping with
other memory types? Add a new function call each time?

Thanks,
Laura

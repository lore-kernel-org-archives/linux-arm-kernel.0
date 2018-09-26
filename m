From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 26 Sep 2018 13:22:09 -0400
Subject: [PATCH V3] PCI: Enable PASID when End-to-End TLP is supported by
 all bridges
In-Reply-To: <e2da631e-ccbf-af94-ea0c-6c6c4d842768@codeaurora.org>
References: <1530372264-20653-1-git-send-email-okaya@codeaurora.org>
 <20180926162235.GA30177@araj-mobl1.jf.intel.com>
 <e2da631e-ccbf-af94-ea0c-6c6c4d842768@codeaurora.org>
Message-ID: <ff87c6ab-fdd2-c75d-285a-e2d19c640e2b@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/26/2018 1:20 PM, Sinan Kaya wrote:
> 
> This?patch?actually?broke?the?integrated?endpoints?like?you?were?mentioning.
> It?was?fixed?by?a?follow?up?patch?from?nvidia?guys.
> 
> https://github.com/torvalds/linux/commit/9d27e39d309c93025ae6aa97236af15bef2a5f1f#diff-a7f0acd715e991df5dfb450d2b9abebc 
> 

Turns out Felix works at AMD. Apologies for the name confusion.

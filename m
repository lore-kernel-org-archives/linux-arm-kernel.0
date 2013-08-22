From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 22 Aug 2013 14:08:32 -0600
Subject: [PATCH v6 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <5214D0F0.10209@samsung.com>
References: <1376924669-28873-1-git-send-email-m.szyprowski@samsung.com>
 <1376924669-28873-4-git-send-email-m.szyprowski@samsung.com>
 <521292E0.105@wwwdotorg.org> <98354044.bRIxVeGEeu@flatron>
 <5212997A.5060206@wwwdotorg.org> <52134B92.10308@samsung.com>
 <52139AE7.4050300@wwwdotorg.org> <5214D0F0.10209@samsung.com>
Message-ID: <52166FC0.1090804@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2013 08:38 AM, Marek Szyprowski wrote:
...
>> >> b) Adjust memory.txt not to mention any specific property names, but
>> >> simply mention that other DT nodes can refer to define memory regions by
>> >> phandle, and leave it up to individual bindings to define which property
>> >> they use to reference the memory regions, perhaps with memory.txt
>> >> providing a recommendation of memory-region for the simple case

I think if we just make that change to the binding doc, it'll be fine.
It's obvious how to extend the binding then.

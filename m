From: saaguirre@ti.com (Aguirre, Sergio)
Date: Fri, 27 Aug 2010 10:05:29 -0500
Subject: How to add a generic multi-platform check if DMA can reach a page?
Message-ID: <A24693684029E5489D1D202277BE8944719829FD@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry if I'm asking a basic platform question, but please bear with me a little bit.

I want to know what is the proper generic way of checking if, in my current running
platform, a page is reachable by DMA or not.

The reason of my question is, videobuf library for V4L2 devices is assuming all the time
That pages in Highmem region are _never_ reachable by DMA, no matter what the platform is.

I think that assumption is just not generic enough, so, that's why I want to know
If there's a generic multi-platform mechanism of knowing if a page is reachable by DMA.

I'll appreciate very much your answer/opinion.

Regards,
Sergio

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Jul 2013 20:32:11 -0700
Subject: [PATCH] decompressors: fix "no limit" output buffer length
In-Reply-To: <51EDE724.5020507@nvidia.com>
References: <1374476169-32194-1-git-send-email-acourbot@nvidia.com>
 <1374516481.14712.3.camel@linaro1.home> <51EDE724.5020507@nvidia.com>
Message-ID: <51EDF93B.1070101@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2013 07:15 PM, Alex Courbot wrote:
...
> Although the patch seems ok to me in its current form, there are two
> points for which I still have small doubts:
> 
> 1) Whether size_t and pointers will have the same size on all platforms.

ptrsize_t?

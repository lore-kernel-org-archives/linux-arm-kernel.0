From: dave.long@linaro.org (David Long)
Date: Mon, 24 Mar 2014 14:34:01 -0400
Subject: [PATCH 1/3] ARM: kprobes: Prevent known test failures stopping
 other tests running
In-Reply-To: <20140324165601.GR7528@n2100.arm.linux.org.uk>
References: <1394556894-18592-1-git-send-email-tixy@linaro.org>
 <1394556894-18592-2-git-send-email-tixy@linaro.org>
 <53304CB3.6040409@linaro.org> <1395679745.3465.41.camel@linaro1.home>
 <20140324165601.GR7528@n2100.arm.linux.org.uk>
Message-ID: <53307A99.1070207@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/14 12:56, Russell King - ARM Linux wrote:
> On Mon, Mar 24, 2014 at 04:49:05PM +0000, Jon Medhurst (Tixy) wrote:
>> Yes, I now see this in Russell's patch tracker (with a less verbose
>> commit message) as patch 7978, and it's marked as "Applied to git-curr
>> (uprobes branch)". Perhaps it got dropped along with the rest of the
>> uprobes branch when the config problems were discovered, Russell?
>
> If it was applied to the uprobes branch, and it wasn't part of David's
> uprobes git pull request, then yes, it doesn't exist anymore.
>

OK.  Just to be absolutely clear:  this doesn't create any new problem, 
but we do then need it in Tixy's new patchset in order to fix this older 
bug.

-dl

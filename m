From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 2 Aug 2013 21:52:47 -0400 (EDT)
Subject: [PATCH v2 0/6] ARM: mm: Extend the runtime patch stub for PAE
 systems
In-Reply-To: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <alpine.LFD.2.03.1308022150210.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 31 Jul 2013, Santosh Shilimkar wrote:

> This is version 2 of the series which addresses the comments/suggestions
> we received on earlier version. The series trying to extend the existing
> v2p runtime patching for LPAE machines which can have physical memory
> beyond 4 GB. Keystone is one such ARM machine.

FYI: I never received patch 1/6.

> In testing various modes(LPAE/non-LPAE, ARM/THMUB), we found an issue
> with the patching code for THUMB2 build. So there is a patch added in
> the series to address it. I was planning to squash it in the parent
> 64 bit patch but thought of keeping it separate for ease of review.
> We can squash it while merging the patches. 

Is this an issue with the current code before implementing 64 bit offset 
patching?


Nicolas

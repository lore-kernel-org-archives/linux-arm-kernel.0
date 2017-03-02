From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Mar 2017 15:05:50 +0000
Subject: [PATCHv2 14/14] treewide: Decouple cacheflush.h and set_memory.h
In-Reply-To: <1488413706-9739-15-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
 <1488413706-9739-15-git-send-email-labbott@redhat.com>
Message-ID: <20170302150550.GC12157@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 01, 2017 at 04:15:06PM -0800, Laura Abbott wrote:
> Now that all call sites, completely decouple cacheflush.h and
> set_memory.h
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

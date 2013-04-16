From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 16 Apr 2013 17:04:19 +0100
Subject: [PATCH] Report double word access atomicity on LPAE enabled
 targets through AUXV
In-Reply-To: <CD54D5A4-2E19-49D9-B6E7-051F36AB5DF8@oracle.com>
References: <C3FF039D-7DE3-4A99-8317-789094095D8B@oracle.com>
 <20130408142406.GL17995@n2100.arm.linux.org.uk>
 <20130408155749.GS17476@mudshark.cambridge.arm.com>
 <CD54D5A4-2E19-49D9-B6E7-051F36AB5DF8@oracle.com>
Message-ID: <20130416160419.GC30292@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 09:58:43PM +0100, Vladimir Danushevsky wrote:
> Below is a modified patch based on suggestions so far:

You need to add a description, maybe just the comment that you already
added in the code.

> Signed-off-by: Vladimir Danushevsky <vladimir.danushevsky@oracle.com>
> 
>  include/uapi/asm/hwcap.h |    1 +
>  kernel/setup.c           |   13 +++++++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)

Otherwise,

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

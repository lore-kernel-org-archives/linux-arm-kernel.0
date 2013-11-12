From: msalter@redhat.com (Mark Salter)
Date: Tue, 12 Nov 2013 09:50:42 -0500
Subject: [PATCH 03/11] arm: use generic fixmap.h
In-Reply-To: <1384262545-20875-4-git-send-email-msalter@redhat.com>
References: <1384262545-20875-1-git-send-email-msalter@redhat.com>
 <1384262545-20875-4-git-send-email-msalter@redhat.com>
Message-ID: <1384267842.24631.3.camel@deneb.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-11-12 at 08:22 -0500, Mark Salter wrote:
> Signed-off-by: Mark Salter <msalter@redhat.com>
> CC: Russell King <linux@arm.linux.org.uk>
> CC: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/include/asm/fixmap.h | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)

Okay, this one is wrong. I just noticed that arm is different
from other architectures in that increasing fixed indices
convert to increasing virt addresses. Does this need to be
the case or is it okay to change it to match other architectures?

--Mark

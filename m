From: will.deacon@arm.com (Will Deacon)
Date: Thu, 4 May 2017 12:33:21 +0100
Subject: [PATCH v2 0/4] arm64: improve tagged pointer handling
In-Reply-To: <1493825868-30872-1-git-send-email-kristina.martsenko@arm.com>
References: <1493825868-30872-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <20170504113320.GD5417@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kristina,

On Wed, May 03, 2017 at 04:37:44PM +0100, Kristina Martsenko wrote:
> Here are some patches to fix a few issues related to tagged pointer
> handling.

These all look good to me, thanks:

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin -- I think you can take these all as fixes, with CC stable too
(fixes: tags are already in place).

Cheers,

Will

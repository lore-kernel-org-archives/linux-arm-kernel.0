From: yanok@emcraft.com (Ilya Yanok)
Date: Thu, 12 Jan 2012 01:19:52 +0400
Subject: [PATCH V2] OMAP3: hwmod_data: register dss hwmods after dss_core
In-Reply-To: <4EFD8C36.9000208@ti.com>
References: <1324562563-27119-1-git-send-email-yanok@emcraft.com>
 <1325028693-14728-1-git-send-email-yanok@emcraft.com>
 <4EFD8C36.9000208@ti.com>
Message-ID: <4F0DFCF8.4070008@emcraft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Archit.

On 30.12.2011 14:02, Archit Taneja wrote:
> This looks fine, but it should be needed for other OMAP2 and OMAP4 also.
> If you could extend the patch we could test it out for the other OMAPs.

OMAP2 and OMAP4 don't need this as they have single hwmod list, so
correct ordering can be handled just by ordering list items.

Regards, Ilya.

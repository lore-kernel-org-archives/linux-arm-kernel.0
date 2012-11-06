From: olof@lixom.net (Olof Johansson)
Date: Tue, 6 Nov 2012 06:44:07 -0800
Subject: [PATCH 00/15] ARM: Patchset for CLPS711X
In-Reply-To: <1351762006-27368-16-git-send-email-shc_work@mail.ru>
References: <1351762006-27368-1-git-send-email-shc_work@mail.ru>
 <1351762006-27368-16-git-send-email-shc_work@mail.ru>
Message-ID: <20121106144407.GG27284@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2012 at 01:26:46PM +0400, Alexander Shiyan wrote:
> Here is a next small patchset for a CLPS711X-target.
> The main direction of this patchset - approaching the platform to the
> possibility of using configurations with multiple platforms in a single
> kernel. Added support of the majority of the necessary kernel symbol.
> Also part of the driver code used only for the platform was moved to the
> board code and converted to the use of standard drivers.

Hi,

Based on the pending comments from Russell, I'll hold off merging these. Please
repost with his comments addressed and I'll be happy to merge this set.

Thanks,

-Olof

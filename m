From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Fri, 9 Sep 2011 23:45:54 +0400
Subject: [PATCHv2] ARM: remove missing cns3xxx includes
In-Reply-To: <1315145389-3377-1-git-send-email-kaloz@openwrt.org>
References: <1315145389-3377-1-git-send-email-kaloz@openwrt.org>
Message-ID: <20110909194554.GA1934@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Sep 04, 2011 at 04:09:49PM +0200, Imre Kaloz wrote:
> Commit c9d95fbe59e426eed7f16e7cac812e46ac4772d0 "ARM: convert PCI defines
> to variables" deleted cns3xxx' hardware.h, but didn't remove references
> for it, so do it now.
> 
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>

Tommy Lin sent a similar fix earlier. I combined your commit message
and added your Signed-off-by line for the credits.

Thank you!

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com

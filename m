From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 20 Aug 2013 17:50:38 -0300
Subject: [PATCH v3 5/5] clocksource: armada-370-xp: Add detailed clock
 requirements in devicetree binding
In-Reply-To: <5213D24A.50908@wwwdotorg.org>
References: <1377013554-23389-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377013554-23389-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <5213D24A.50908@wwwdotorg.org>
Message-ID: <20130820205037.GA23955@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 02:32:10PM -0600, Stephen Warren wrote:
> On 08/20/2013 09:45 AM, Ezequiel Garcia wrote:
> > Specifies the required clock inputs for each supported compatible.
> > Armada 370 requires a single clock phandle, and Armada XP requires
> > two clock phandles with clock-names "nbclk" and "fixed".
> 
> This patch,
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 

Thanks!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com

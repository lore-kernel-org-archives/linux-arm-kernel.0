From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Nov 2012 09:59:49 -0800
Subject: [PATCH 032/493] arm: remove use of __devexit_p
In-Reply-To: <1353349642-3677-32-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-32-git-send-email-wfp5p@virginia.edu>
Message-ID: <20121120175949.GI18567@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Bill Pemberton <wfp5p@virginia.edu> [121119 10:29]:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.

For the arch/arm/*omap*/* touching patches:

Acked-by: Tony Lindgren <tony@atomide.com>

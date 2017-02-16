From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 16 Feb 2017 15:30:57 +0530
Subject: [PATCH 37/37] ARM: dts: DRA7: Add pcie1 dt node for EP mode
In-Reply-To: <20170120183000.GF7403@atomide.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-38-git-send-email-kishon@ti.com>
 <20170120183000.GF7403@atomide.com>
Message-ID: <58A57859.5090308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Saturday 21 January 2017 12:00 AM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [170112 02:34]:
>> Add pcie1 dt node in order for the controller to operate in
>> endpoint mode. However since none of the dra7 based boards have
>> slots configured to operate in endpoint mode, keep EP mode
>> disabled.
> 
> Can this be merged separately later on without breaking anything?

yes, I'll resend this once rest of the EP support gets in.

Thanks
Kishon

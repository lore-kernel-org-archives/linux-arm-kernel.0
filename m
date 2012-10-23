From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 23 Oct 2012 07:50:28 +0200
Subject: [PATCH 3/5] arm: mvebu: Added IPI support via doorbells
In-Reply-To: <20121023054455.GP21046@lunn.ch>
References: <1350925368-24243-1-git-send-email-gregory.clement@free-electrons.com>
 <1350925368-24243-4-git-send-email-gregory.clement@free-electrons.com>
 <20121022173028.GM21046@lunn.ch>
 <50859976.6080601@free-electrons.com>
 <20121022200708.GO21046@lunn.ch>
 <5085B666.1040500@free-electrons.com>
 <20121023071419.222c46d3@skate> <20121023054455.GP21046@lunn.ch>
Message-ID: <20121023075028.0f83d58e@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Tue, 23 Oct 2012 07:44:55 +0200, Andrew Lunn wrote:

> Thanks for the clear reply. Does the binding documentation make this
> clear? Should it be extended to indicate which address range should be
> used?

Indeed it should be clarified in the DT binding documentation. I'll see
with Gr?gory to add such a clarification in his v2 of the SMP patch
set, if that's ok with you.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

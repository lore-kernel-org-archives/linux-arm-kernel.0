From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 16 May 2012 18:17:43 -0600 (MDT)
Subject: [PATCHv2 14/19] ARM: OMAP4: wakeupgen: enable clocks for
 save_secure_all
In-Reply-To: <1336990730-26892-15-git-send-email-t-kristo@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
 <1336990730-26892-15-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1205161809230.2921@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tero

On Mon, 14 May 2012, Tero Kristo wrote:

> save_secure_all needs l3_main_3_ick and l4_secure_clkdm enabled,
> otherwise the secure ROM code will crash.

Do we know why the l3_main_3 interconnect has to be enabled?  Is this 
needed to access some L3 or instrumentation registers?


- Paul

From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 Mar 2012 10:28:20 -0700
Subject: [PATCH 05/12] Add dummy smsc911x regulators to cm-t35.
In-Reply-To: <4F71E290.2050403@compulab.co.il>
References: <1332494504-10251-1-git-send-email-Russ.Dill@ti.com>
 <1332494504-10251-6-git-send-email-Russ.Dill@ti.com>
 <4F71E290.2050403@compulab.co.il>
Message-ID: <20120327172819.GQ9859@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Igor Grinberg <grinberg@compulab.co.il> [120327 08:56]:
> Hi Russ,
> 
> This patch works, but can we, please use the attached patch instead?

Hmm what's the difference here? Do you have some real controllable
regulator for one of the smsc911x instances?

Anyways, I take it that you have tested that both smsc911x interfaces
work now?

Regards,

Tony

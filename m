From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Nov 2011 19:22:46 +0100
Subject: [PATCH] at91: at91-ohci: fix set/get power
In-Reply-To: <1321112773-8360-1-git-send-email-plagnioj@jcrosoft.com>
References: <1321112773-8360-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20111114192246.22b25745@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Sat, 12 Nov 2011 16:46:13 +0100,
Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com> a ?crit :

> in commit aa6e52a35 we introduce the support of overcurrent notification
> but the set and get of the power without checking if the gpio is valid or not
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

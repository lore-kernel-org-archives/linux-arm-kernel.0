From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Mon, 23 Oct 2017 11:57:18 +0300
Subject: [PATCH] ARM: mvebu: Use common error handling code in
 mvebu_armada_pm_init()
In-Reply-To: <1c378b21-f10a-3a3a-fcee-8f0c0214a8fe@users.sourceforge.net>
References: <1c378b21-f10a-3a3a-fcee-8f0c0214a8fe@users.sourceforge.net>
Message-ID: <20171023085718.lga7auriq7paw2hv@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The error handling in mvebu_armada_pm_init() is incomplete and this
patch just smudges it around without fixing anything.

regards,
dan carpenter

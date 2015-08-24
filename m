From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon, 24 Aug 2015 23:12:25 +0200
Subject: [PATCH 0/2] convert null test to IS_ERR test
Message-ID: <1440450747-10080-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 323de9efdf3e ("pinctrl: make pinctrl_register() return proper
error code"), pinctrl_register returns an error code rather than NULL on
failure.  Most drivers were updated at that time.  Update some drivers that
were introduced more recently.

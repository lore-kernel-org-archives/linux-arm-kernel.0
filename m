From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 29 Dec 2013 23:47:15 +0100
Subject: [PATCH 0/25] fix error return code
Message-ID: <1388357260-4843-1-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches fix cases where the return variable is not set to an error
code in an error case.

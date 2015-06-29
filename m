From: davem@davemloft.net (David Miller)
Date: Mon, 29 Jun 2015 09:28:23 -0700 (PDT)
Subject: [PATCH] net-Liquidio: Delete unnecessary checks before the
 function call "vfree"
In-Reply-To: <55912270.4030201@users.sourceforge.net>
References: <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <55912270.4030201@users.sourceforge.net>
Message-ID: <20150629.092823.165902372857729782.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 29 Jun 2015 12:48:16 +0200

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 29 Jun 2015 12:22:24 +0200
> 
> The vfree() function performs also input parameter validation.
> Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied.

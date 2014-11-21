From: davem@davemloft.net (David Miller)
Date: Fri, 21 Nov 2014 15:14:53 -0500 (EST)
Subject: [PATCH 1/1] net: Xilinx: Deletion of unnecessary checks before
 two function calls
In-Reply-To: <546DF1A2.8090208@users.sourceforge.net>
References: <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <546DF1A2.8090208@users.sourceforge.net>
Message-ID: <20141121.151453.2056435337330014938.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 20 Nov 2014 14:50:26 +0100

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 20 Nov 2014 14:47:12 +0100
> 
> The functions kfree() and of_node_put() test whether their argument is NULL
> and then return immediately. Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied.

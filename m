From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Thu, 20 Sep 2012 22:19:56 +0200
Subject: [PATCH 7/10] WAN: Remove redundant HDLC info printed by IXP4xx HSS
 driver.
In-Reply-To: <m3txus4hgm.fsf@intrepid.localdomain> (Krzysztof Halasa's message
 of "Thu, 20 Sep 2012 21:33:45 +0200")
References: <m3txus4hgm.fsf@intrepid.localdomain>
Message-ID: <m3fw6c30r7.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- a/drivers/net/wan/ixp4xx_hss.c
+++ b/drivers/net/wan/ixp4xx_hss.c
@@ -1363,7 +1363,7 @@ static int __devinit hss_init_one(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, port);
 
-	netdev_info(dev, "HSS-%i\n", port->id);
+	netdev_info(dev, "initialized\n");
 	return 0;
 
 err_free_netdev:

-- 
Krzysztof Halasa

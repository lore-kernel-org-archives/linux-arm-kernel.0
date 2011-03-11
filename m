From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 11 Mar 2011 15:11:10 +0100
Subject: [RFC PATCHv2 2/2] ux500: Export U8500 SoC info through sysfs
In-Reply-To: <1299846911-15782-3-git-send-email-maxime.coquelin-nonst@stericsson.com>
References: <1299846911-15782-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299846911-15782-3-git-send-email-maxime.coquelin-nonst@stericsson.com>
Message-ID: <20110311141110.GS9351@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:35 Fri 11 Mar     , Maxime Coquelin wrote:
> ST-Ericsson's U8500 implementation.
> Register sysfs SoC interface, and exports:
> 	- Machine name
> 	- Family name
> 	- SoC ID
> 	- Silicon process
> 	- Silicon revision number.
I propose some weeks ago exactly the same kind of patch

and Greg point that we need to create a bus

Best Regards,
J.

From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Oct 2009 17:19:17 +0200
Subject: [PATCH] at91: support for eco920
In-Reply-To: <1256115527-20635-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091021084826.GA29667@n2100.arm.linux.org.uk>
	<1256115527-20635-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20091021151917.GE19714@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:58 Wed 21 Oct     , Uwe Kleine-K?nig wrote:
> CONFIG_MACH_ECO920 is enabled in at91rm9200dk_defconfig.  The name is
> wrong, but this is better than adding another defconfig or don't get
> compile coverage at all./
in this case it will be better to have a generic rm9200 defconfig

Best Regards,
J.

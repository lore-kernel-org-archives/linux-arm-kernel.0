From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Sat, 4 Apr 2015 00:46:33 +0300
Subject: [PATCH v1.1 07/14] media: omap3isp: remove unused clkdev
In-Reply-To: <1428097502-19593-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1428097502-19593-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <20150403214633.GQ20756@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 04, 2015 at 12:45:02AM +0300, Laurent Pinchart wrote:
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> No merged platform supplies xclks via platform data.  As we want to
> slightly change the clkdev interface, rather than fixing this unused
> code, remove it instead.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Acked-by: Sakari Ailus <sakari.ailus@iki.fi>

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk

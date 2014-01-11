From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 18:58:50 +0000
Subject: [PATCH v2 0/28] drm/i2c: tda998x: add DT support and other
 improvements
In-Reply-To: <20140109115651.482e2db1@armhf>
References: <20140109115651.482e2db1@armhf>
Message-ID: <20140111185850.GM15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 09, 2014 at 11:56:51AM +0100, Jean-Francois Moine wrote:
> This patch set contains various extensions to the tda998x driver:
> 
> - simplify the i2c read/write
> - code cleanup and fix some small errors
> - use HDMI constants
> - don't read write-only registers
> - add DT support
> - use irq for connection status and EDID read
> - get a better status of the HDMI connector
> - use the tda998x video format when cea mode
> - add tda998x codec interface
> 
> - v2
> 	- decompose patches with different topics
> 	- fix some bad i2c register values
> 	- add audio codec interface
> 

Next time you post patches, please ensure that each patch is a reply
to your series covering message, so that they can be easily threaded
together.  It's a pain to have to search around for all the individual
patches amongst other people's traffic.

Thanks.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".

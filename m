From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 15:23:59 +0100
Subject: [PATCH 0/1] ARM: kirkwood: Convert the mplcec4 board to pinctrl
In-Reply-To: <50AA2D8C.90902@mpl.ch>
References: <cover.1353319919.git.s.peter@mpl.ch>
 <20121119111838.GH10259@lunn.ch> <50AA2118.7050700@mpl.ch>
 <20121119121833.GI10259@lunn.ch> <50AA2D8C.90902@mpl.ch>
Message-ID: <20121119152359.13786aae@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Stefan Peter,

On Mon, 19 Nov 2012 14:01:00 +0100, Stefan Peter wrote:

> kirkwood-pinctrl f1010000.pinctrl: unknown pin mmp13

It should be 'mpp13', not 'mmp13'.

The problem is in your Device Tree as well :-)

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

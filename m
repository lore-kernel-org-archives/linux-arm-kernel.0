From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Mar 2015 15:19:12 +0000
Subject: [PATCH v2] dts: cubox: Map gpio-keys to gpio3 8
In-Reply-To: <20150323133252.GE28410@dragon>
References: <1426542829-16786-1-git-send-email-george.joseph@fairview5.com>
 <20150323133252.GE28410@dragon>
Message-ID: <20150323151912.GS8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 09:32:54PM +0800, Shawn Guo wrote:
> On Mon, Mar 16, 2015 at 03:53:49PM -0600, George Joseph wrote:
> > The Cubox has a recessed button between the HDMI and RJ-45 connectors
> > that wasn't mapped in the device tree, so I've mapped it to gpio-keys
> > BTN_0.
> > 
> > Signed-off-by: George Joseph <george.joseph@fairview5.com>
> > Tested-by: George Joseph <george.joseph@fairview5.com>
> 
> Russell,
> 
> Are you fine with this patch?

No.  It's not submitted against a version of the DT file which has the
new licensing, so it cocks up that change (and would mean I'd need
George to agree to the new license.)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

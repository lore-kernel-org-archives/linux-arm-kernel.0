From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Feb 2015 14:46:22 +0000
Subject: [PATCH v4 2/8] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <1421663463-1426-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
References: <1421663016-1327-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1421663463-1426-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
Message-ID: <20150202144622.GD8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 06:31:03PM +0800, Vincent Yang wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> Add driver for the ARM Message-Handling-Unit (MHU).

Is this an AMBA Primecell peripheral?  If so, it should not be a platform
driver.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.

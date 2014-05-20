From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Tue, 20 May 2014 11:15:10 +0200
Subject: [PATCH v4 1/7] phy: add a driver for the Berlin SATA PHY
In-Reply-To: <537B1C35.20107@gmail.com>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
 <1400576675-25265-2-git-send-email-antoine.tenart@free-electrons.com>
 <537B1C35.20107@gmail.com>
Message-ID: <20140520091510.GA25381@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 11:11:17AM +0200, Sebastian Hesselbarth wrote:
> On 05/20/2014 11:04 AM, Antoine T?nart wrote:
> >+#define HOST_VSA_ADDR		0x0
> >+#define HOST_VSA_DATA		0x4
> >+#define PORT_VSR_ADDR           0x78
> >+#define PORT_VSR_DATA           0x7c
> 
> Above two lines are indented with spaces.

Indeed ... sorry for that.

> >+#define PORT_SCR_CTL		0x2c
> >+
> >+#define CONTROL_REGISTER	0x0
> >+#define MBUS_SIZE_CONTROL	0x4
> >+
> >+#define POWER_DOWN_PHY0			BIT(6)
> >+#define POWER_DOWN_PHY1			BIT(14)
> >+#define MBUS_WRITE_REQUEST_SIZE_128	(BIT(2) << 16)
> >+#define MBUS_READ_REQUEST_SIZE_128	(BIT(2) << 19)
> >+
> >+#define PHY_BASE                0x200
> 
> ditto.
> 
> >+
> >+/* register 0x01 */
> >+#define REF_FREF_SEL_25         BIT(0)
> >+#define PHY_MODE_SATA           (0x0 << 5)
> 
> ditto.
> 
> >+
> >+/* register 0x02 */
> >+#define USE_MAX_PLL_RATE        BIT(12)
> 
> ditto.
> 
> >+
> >+/* register 0x23 */
> >+#define DATA_BIT_WIDTH_10       (0x0 << 10)
> >+#define DATA_BIT_WIDTH_20       (0x1 << 10)
> >+#define DATA_BIT_WIDTH_40       (0x2 << 10)
> 
> ditto.
> 
> >+
> >+/* register 0x25 */
> >+#define PHY_GEN_MAX_1_5         (0x0 << 10)
> >+#define PHY_GEN_MAX_3_0         (0x1 << 10)
> >+#define PHY_GEN_MAX_6_0         (0x2 << 10)
> 
> ditto.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

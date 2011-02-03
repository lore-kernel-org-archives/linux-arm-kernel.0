From: balbi@ti.com (Felipe Balbi)
Date: Thu, 3 Feb 2011 14:54:38 +0200
Subject: [PATCH v2 2/2] omap3sdp: clean regulator supply mapping in
	board file
In-Reply-To: <1296737122-20765-3-git-send-email-rnayak@ti.com>
References: <1296737122-20765-1-git-send-email-rnayak@ti.com>
	<1296737122-20765-2-git-send-email-rnayak@ti.com>
	<1296737122-20765-3-git-send-email-rnayak@ti.com>
Message-ID: <20110203125438.GC28607@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 03, 2011 at 06:15:22PM +0530, Rajendra Nayak wrote:
> clean the regulator supply mapping data in the 3430sdp
> board file (which is spread all over) by moving all
> of them together.
> Also use the REGULATOR_SUPPLY macro and remove instances
> of mapping dev pointers at run time.
> Additonally define all regulator_consumer_supply as
> array's and use ARRAY_SIZE macro to define
> num_consumer_supplies.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi

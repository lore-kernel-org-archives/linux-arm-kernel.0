From: balbi@ti.com (Felipe Balbi)
Date: Thu, 3 Feb 2011 14:03:01 +0200
Subject: [PATCH 2/2] omap3sdp: clean regulator supply mapping in board file
In-Reply-To: <1296732705-12818-3-git-send-email-rnayak@ti.com>
References: <1296732705-12818-1-git-send-email-rnayak@ti.com>
	<1296732705-12818-2-git-send-email-rnayak@ti.com>
	<1296732705-12818-3-git-send-email-rnayak@ti.com>
Message-ID: <20110203120301.GL23561@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 03, 2011 at 05:01:45PM +0530, Rajendra Nayak wrote:
> clean the regulator supply mapping data in the 3430sdp
> board file (which is spread all over) by moving all
> of them together.
> Also use the REGULATOR_SUPPLY macro and remove instances
> of mapping dev pointers at run time.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

same comment is valid for this patch.

-- 
balbi

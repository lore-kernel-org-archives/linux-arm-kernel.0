From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Apr 2013 13:16:52 +0100
Subject: [RFC PATCHv2 arm: initial TI-Nspire support]
In-Reply-To: <8E071E2D-4FF3-487E-A53B-B6A7C427E421@gmail.com>
References: <8E071E2D-4FF3-487E-A53B-B6A7C427E421@gmail.com>
Message-ID: <20130419121652.GK14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 11, 2013 at 09:51:43PM +1000, Daniel Tang wrote:
> +	.cntl		= (CNTL_BGR | CNTL_LCDTFT | CNTL_LCDVCOMP(1) |
> +				CNTL_LCDBPP16_565),

NAK.  Use the panel capabilities instead.

From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Tue, 27 Feb 2018 13:10:36 +0000
Subject: [PATCH 0/2] arm: Support for Renesas RZ/N1D (R9A06G032)
In-Reply-To: <1519647518-15579-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1519647518-15579-1-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <HK2PR0601MB1393B2D7E0C96590482C3726F5C00@HK2PR0601MB1393.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On 26 February 2018, Michel Pollet wrote:
> 
> This series adds the plain basic support for booting a bare
> kernel on the RZ/N1D-DB Board. It's been trimmed to the strict
> minimum as a 'base', further patches that will add the
> rest of the support, pinctrl, clock architecture and quite
> a few others.
I spoke to Magnus about helping to get the RZ/N1 patches upstream.
We're trying to sort out making the device manual and board schematics
available, hopefully it won't take too long. We're also trying to sort out
access to a board... that might take a bit longer.

btw, what do you want to do about shmobile_defconfig? Should we add
any changes needed for RZ/N1 to it? Note that only one IP block is the
same as R-Car.

Thanks
Phil

From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Jun 2014 11:10:54 -0600
Subject: [PATCHv2 1/2] ARM: tegra: tamonten: add the base board regulators
In-Reply-To: <1403184350-25403-1-git-send-email-alban.bedel@avionic-design.de>
References: <1403184350-25403-1-git-send-email-alban.bedel@avionic-design.de>
Message-ID: <53A3199E.6030409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2014 07:25 AM, Alban Bedel wrote:
> Currently the Tamonten DTS define a fixed regulator for the 5V supply.
> However this regulator is in fact on the base board. Fix this by
> properly defining the regulators found on the base boards.

I've applied the series to Tegra's for-3.17/dt branch.

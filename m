From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 16 Apr 2014 11:10:34 -0600
Subject: [PATCH v4 2/4] USB: EHCI: Export the ehci_hub_control function
In-Reply-To: <1397664012-28022-3-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1397664012-28022-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1397664012-28022-3-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <534EB98A.1000503@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2014 10:00 AM, Laurent Pinchart wrote:
> Platform drivers sometimes need to perform specific handling of hub
> control requests. Make this possible by exporting the ehci_hub_control()
> function which can then be called from a custom hub control handler in
> the default case.

The Tegra parts,
Acked-by: Stephen Warren <swarren@nvidia.com>

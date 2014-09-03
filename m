From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Sep 2014 10:19:56 -0600
Subject: [PATCH v3 1/9] of: Add NVIDIA Tegra XUSB mailbox binding
In-Reply-To: <1409693701-16520-2-git-send-email-abrestic@chromium.org>
References: <1409693701-16520-1-git-send-email-abrestic@chromium.org>
 <1409693701-16520-2-git-send-email-abrestic@chromium.org>
Message-ID: <54073FAC.8030702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2014 03:34 PM, Andrew Bresticker wrote:
> Add device-tree bindings for the Tegra XUSB mailbox which will be used
> for communication between the Tegra xHCI controller's firmware and the
> host processor.

The series,
Reviewed-by: Stephen Warren <swarren@nvidia.com>

I'd like Thierry to review at least the XUSB pinctrl and all DT binding 
changes too, if possible.

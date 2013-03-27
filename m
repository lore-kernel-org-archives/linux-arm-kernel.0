From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 27 Mar 2013 11:13:30 -0600
Subject: [PATCH] ARM: tegra: add clocks property to sound nodes
In-Reply-To: <1364340079-3762-1-git-send-email-swarren@wwwdotorg.org>
References: <1364340079-3762-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <515328BA.7080501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2013 05:21 PM, Stephen Warren wrote:
> Audio-related clocks need to be represented in the device tree. Update
> bindings to describe which clocks are needed, and DT files to include
> those clocks.

Applied to Tegra's for-3.10/dt branch.

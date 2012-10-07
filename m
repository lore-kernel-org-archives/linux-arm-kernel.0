From: olof@lixom.net (Olof Johansson)
Date: Sun, 7 Oct 2012 07:06:24 -0700
Subject: [PATCH 1/2] ARM: tegra: fix invalid unit-address in tegra*.dtsi
In-Reply-To: <1349205048-22228-1-git-send-email-swarren@wwwdotorg.org>
References: <1349205048-22228-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121007140624.GA24933@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2012 at 01:10:47PM -0600, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Unit addresses, whilst written in hex, don't contain a 0x prefix.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> A couple of small cleanups/tweaks for 3.7 if possible.

Applied 1-2 to fixes.


-Olof

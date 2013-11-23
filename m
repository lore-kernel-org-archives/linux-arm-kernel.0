From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 16:36:58 -0500
Subject: [PATCH] ARM: keystone: enable big endian support
In-Reply-To: <1384971859-7748-1-git-send-email-taras.kondratiuk@linaro.org>
References: <1384971859-7748-1-git-send-email-taras.kondratiuk@linaro.org>
Message-ID: <52911FFA.7030002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 November 2013 01:24 PM, Taras Kondratiuk wrote:
> Keystone code is big endian compatible,
> so mark it as one that supports big endian.
> 
> Note this patch just allows to select Big endian build
> for ARCH_KEYSTONE, but it does not enable BE by default.
> 
> Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
> ---
Applied.. Thanks for the patch

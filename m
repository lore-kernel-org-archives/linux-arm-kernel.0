From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 25 Feb 2014 10:59:50 -0700
Subject: [PATCH] ARM: tegra: remove tegra EMC scaling driver
In-Reply-To: <1392759679-13751-1-git-send-email-swarren@wwwdotorg.org>
References: <1392759679-13751-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <530CDA16.9090300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2014 02:41 PM, Stephen Warren wrote:
> Nothing calls into the Tegra EMC (External Memory Controller) scaling
> driver any more, so it's dead code. Remove it.

I have applied this to Tegra's for-3.15/soc branch.

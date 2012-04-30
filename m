From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 May 2012 00:26:32 +0100
Subject: [PATCH] ARM: disable SUSPEND/ARCH_SUSPEND_POSSIBLE for ARCH_TEGRA
In-Reply-To: <4F9F1E4E.4020604@wwwdotorg.org>
References: <1335381650-7666-1-git-send-email-swarren@wwwdotorg.org>
 <4F9F1E4E.4020604@wwwdotorg.org>
Message-ID: <20120430232632.GA3548@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2012 at 05:20:46PM -0600, Stephen Warren wrote:
> On 04/25/2012 01:20 PM, Stephen Warren wrote:
> > Tegra doesn't yet support system sleep. Explicitly disable support
> > for this feature in Kconfig.
> 
> Russell, Arnd, Olof, should this go through the ARM patch tracker, or
> should I just take it through the Tegra tree? Thanks.

I don't think it really matters - this doesn't change a lot so the
chances of conflicts are relatively low.

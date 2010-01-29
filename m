From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 29 Jan 2010 07:48:45 +0100
Subject: [RFC PATCH 01/12] arm: msm: allow ARCH_MSM to have v7 cpus
In-Reply-To: <1264719577-5436-2-git-send-email-dwalker@codeaurora.org>
References: <1264719577-5436-2-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100129064845.GA1529@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2010-01-28 14:59:26, Daniel Walker wrote:
> ARCH_MSM supports armv7 cpus, so we're pushed the CPU_V6/CPU_V7 selection
> down into the arch/arm/mach-msm/Kconfig.
> 
> Also update the description to be a bit more accurate.
> 
> Signed-off-by: Daniel Walker <dwalker@codeaurora.org>

ack (fwiw).
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

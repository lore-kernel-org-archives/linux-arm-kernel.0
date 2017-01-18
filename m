From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2017 23:31:16 +0000
Subject: [PATCH 2/5] ARM: Makefile: Generalize qcom platform text offset
In-Reply-To: <20170118232726.22876-3-sboyd@codeaurora.org>
References: <20170118232726.22876-1-sboyd@codeaurora.org>
 <20170118232726.22876-3-sboyd@codeaurora.org>
Message-ID: <20170118233115.GV27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 03:27:23PM -0800, Stephen Boyd wrote:
> Some qcom platforms need a specific text offset because the first
> 2MB of memory is reserved for shared memory. Let's just always
> shift the text segment up by 2MB when ARCH_QCOM is selected so
> that we don't have to specify the specific platforms that exhibit
> this problem in Kconfig.

I was really hoping that this sillyness would stop, but I guess
expecting it to stop is asking too much...

Is there really no other option?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.

From: olof@lixom.net (Olof Johansson)
Date: Sun, 22 Dec 2013 11:48:12 -0800
Subject: [PATCH v4 1/2] ARM: mach-moxart: add MOXA ART SoC platform files
In-Reply-To: <1386945188-8316-2-git-send-email-jonas.jensen@gmail.com>
References: <1386945188-8316-1-git-send-email-jonas.jensen@gmail.com>
 <1386945188-8316-2-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20131222194812.GD9144@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 03:33:07PM +0100, Jonas Jensen wrote:
> The MOXA ART SoC is based on Faraday's FA526. This is a ARMv4 32-bit
> 192 MHz CPU with MMU and 16KB/8KB D/I-cache.
> 
> Add platform support for this SoC.
> 
> Also add UC-7112-LX as a machine.
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Applied to next/soc for 3.14. Please follow up on the comments and submit
patches as needed on top of this.

Also, I renamed the patch to be ARM: moxart: ... since we normally leave out
the mach- part.


-Olof

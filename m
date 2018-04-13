From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 13 Apr 2018 14:39:56 -0700
Subject: [PATCH 2/2] ARM: bcm283x: Add missing interrupt for RNG block
In-Reply-To: <1511010253-5006-3-git-send-email-stefan.wahren@i2se.com>
References: <1511010253-5006-1-git-send-email-stefan.wahren@i2se.com>
 <1511010253-5006-3-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20180413213956.22464-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 18 Nov 2017 14:04:13 +0100, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> This patch adds the missing interrupt property to the RNG block
> of BCM283x.
> 
> Link: https://github.com/raspberrypi/linux/issues/2195
> CC: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

Applied to devicetree/next, thanks!
--
Florian

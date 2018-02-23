From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 23 Feb 2018 10:56:09 -0800
Subject: [PATCH 1/3] memory: brcmstb: dpfe: properly mask vendor error bits
In-Reply-To: <1518554440-21805-2-git-send-email-mmayer@broadcom.com>
References: <1518554440-21805-1-git-send-email-mmayer@broadcom.com>
 <1518554440-21805-2-git-send-email-mmayer@broadcom.com>
Message-ID: <20180223185609.16641-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Feb 2018 12:40:38 -0800, Markus Mayer <mmayer@broadcom.com> wrote:
> We were printing the entire 32 bit register rather than just the lower
> 8 bits. Anything above bit 7 is reserved and may be any random value.
> 
> Fixes: 2f330caff577 ("memory: brcmstb: Add driver for DPFE")
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---

Applied to drivers/fixes, thanks!
--
Florian

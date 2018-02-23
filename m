From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 23 Feb 2018 10:56:32 -0800
Subject: [PATCH 2/3] memory: brcmstb: dpfe: fix type declaration of
 variable "ret"
In-Reply-To: <1518554440-21805-3-git-send-email-mmayer@broadcom.com>
References: <1518554440-21805-1-git-send-email-mmayer@broadcom.com>
 <1518554440-21805-3-git-send-email-mmayer@broadcom.com>
Message-ID: <20180223185632.16733-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Feb 2018 12:40:39 -0800, Markus Mayer <mmayer@broadcom.com> wrote:
> In some functions, variable "ret" should be ssize_t, so we fix it.
> 
> Fixes: 2f330caff577 ("memory: brcmstb: Add driver for DPFE")
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---

Applied to drivers/fixes, thanks!
--
Florian

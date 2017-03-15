From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 15 Mar 2017 14:54:47 -0700
Subject: [PATCH] ARM: dts: NSP: disable i2c DT entry by default
In-Reply-To: <1488929695-30428-1-git-send-email-jon.mason@broadcom.com>
References: <1488929695-30428-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <20170315215447.15049-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Mar 2017 18:34:55 -0500, Jon Mason <jon.mason@broadcom.com> wrote:
> The i2c device tree entry should be disabled by default to match the
> current convention in other device tree files. Similarily, enable it on
> the XMC board, where it is being used.
>
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> ---

Applied, thanks!
--
Florian

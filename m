From: rafal@milecki.pl (=?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=)
Date: Fri, 04 Nov 2016 08:07:25 +0100
Subject: [PATCH v6 6/7] net: ethernet: bgmac: add NS2 support
In-Reply-To: <1478236262-3351-7-git-send-email-jon.mason@broadcom.com>
References: <1478236262-3351-1-git-send-email-jon.mason@broadcom.com>
 <1478236262-3351-7-git-send-email-jon.mason@broadcom.com>
Message-ID: <2ff584effa79a918addb147845e761f0@milecki.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-11-04 06:11, Jon Mason wrote:
> Add support for the variant of amac hardware present in the Broadcom
> Northstar2 based SoCs.  Northstar2 requires an additional register to 
> be
> configured with the port speed/duplexity (NICPM).  This can be added to
> the link callback to hide it from the instances that do not use this.
> Also, clearing of the pending interrupts on init is required due to
> observed issues on some platforms.
> 
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

[Resending from Roundcube due to "Wrong MIME labeling on 8-bit character 
texts."
vger.kernel.org reject when using Thunderbird]

Checked for possible regressions on Northstar, looks OK.

Acked-by: Rafa? Mi?ecki <rafal@milecki.pl>

From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 29 Jan 2017 17:35:13 +0100
Subject: [PATCH v2 11/25] mfd: axp20x: add AC power supply cells for
 AXP22X PMICs
In-Reply-To: <20170127085458.18270-12-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-12-quentin.schulz@free-electrons.com>
Message-ID: <20170129163513.m7y4vbjgthh2esg4@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 27, 2017 at 09:54:44AM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs expose the status of AC power
> supply.
> 
> This adds the AC power supply driver to the MFD cells of the AXP22X
> PMICs.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170129/a29831f3/attachment.sig>

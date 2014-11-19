From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Nov 2014 17:51:54 +0000
Subject: [PATCH 2/4 V3] ASoC: Samsung: Add arndale_rt5631 machine driver
In-Reply-To: <1415880864-2246-3-git-send-email-krishna.md@samsung.com>
References: <1415880864-2246-1-git-send-email-krishna.md@samsung.com>
 <1415880864-2246-3-git-send-email-krishna.md@samsung.com>
Message-ID: <20141119175154.GI22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 05:44:22PM +0530, Krishna Mohan Dani wrote:

> Signed-off-by: Krishna Mohan Dani <krishna.md@samsung.com>
> ---
>  sound/soc/samsung/Kconfig          |    6 ++
>  sound/soc/samsung/Makefile         |    2 +
>  sound/soc/samsung/arndale_rt5631.c |  150 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 158 insertions(+)

This is fine but it is missing a binding document, please add one.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141119/f98b75c5/attachment.sig>

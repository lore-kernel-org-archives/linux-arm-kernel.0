From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 3 Apr 2013 17:57:02 +0100
Subject: [PATCH 1/2] ASoC: Samsung: return error if drvdata is not set
In-Reply-To: <1364901782-16619-1-git-send-email-padma.v@samsung.com>
References: <1364901782-16619-1-git-send-email-padma.v@samsung.com>
Message-ID: <20130403165702.GB11305@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 04:53:01PM +0530, Padmavathi Venna wrote:
> From: Prathyush K <prathyush.k@samsung.com>
> 
> This patch fixes a possible crash in case drvdata for the secondary
> device is not set.

Applied both, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130403/78b589c9/attachment-0001.sig>

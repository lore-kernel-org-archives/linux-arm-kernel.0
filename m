From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Oct 2014 22:35:21 +0000
Subject: [PATCH 3/6] ASoC: kirkwood: get rid of armada-370-db driver
In-Reply-To: <1414512524-24466-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414512524-24466-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414512524-24466-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20141028223521.GL18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 05:08:41PM +0100, Thomas Petazzoni wrote:
> Now that the Armada 370 DB audio complex is fully described in the
> Device Tree using the simple-card DT binding, the armada-370-db audio
> machine driver can be removed.

This is just removing support for the old binding which is
incompatible...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/05eecdf4/attachment.sig>

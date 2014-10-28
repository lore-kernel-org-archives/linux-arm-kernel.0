From: broonie@kernel.org (Mark Brown)
Date: Tue, 28 Oct 2014 00:43:28 +0000
Subject: [PATCH V3 1/2] ARM: pxa: spitz: register spitz-audio device
In-Reply-To: <1414173005-20967-1-git-send-email-dbaryshkov@gmail.com>
References: <1414173005-20967-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20141028004328.GN18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 09:50:04PM +0400, Dmitry Eremin-Solenikov wrote:
> Register spitz-audio device to be used by ASoC driver to bind ASoC
> platform driver. Currently old 'soc-audio' approach is used, which needs
> to be replaced with proper device.

Applied both, thanks.  If there's some issue with the arch/arm stuff I
can easily drop this or tag that commit for cross-merge.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141028/684891fa/attachment.sig>

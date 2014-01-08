From: broonie@kernel.org (Mark Brown)
Date: Wed, 8 Jan 2014 18:45:43 +0000
Subject: [PATCH 3/4] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <20140108183939.GD9724@e102568-lin.cambridge.arm.com>
References: <1389201013-23794-1-git-send-email-broonie@kernel.org>
 <1389201013-23794-3-git-send-email-broonie@kernel.org>
 <20140108183939.GD9724@e102568-lin.cambridge.arm.com>
Message-ID: <20140108184543.GX31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 06:39:39PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Jan 08, 2014 at 05:10:12PM +0000, Mark Brown wrote:
> > From: Mark Brown <broonie@linaro.org>

> > +		/* check if the cpu is marked as "disabled", if so ignore */
> > +		if (!of_device_is_available(cn))
> > +			continue;

> This check must go. As I mentioned, either we define what this means properly
> or to me the status property of cpu nodes must not be relied upon on ARM.

Meh, sorry - forgot to squash in that patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140108/81ab1777/attachment-0001.sig>

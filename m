From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Jul 2014 19:26:01 +0100
Subject: [RFC 1/5] regulator: core: Get voltage from parent if not
 available
In-Reply-To: <1406651339-28901-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1406651339-28901-1-git-send-email-javier.martinez@collabora.co.uk>
 <1406651339-28901-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140729182601.GA17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 06:28:55PM +0200, Javier Martinez Canillas wrote:
> Load switches are modeled as regulators but they just provide
> the voltage of their parent input supply. So the drivers for

Applied, thanks.  The term "load switch" is a bit unusual - they're
usually just called switches (or sometimes FETs since that tends to be
the implementation).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/310499cd/attachment.sig>

From: broonie@kernel.org (Mark Brown)
Date: Fri, 4 Jul 2014 20:28:57 +0100
Subject: [PATCH] ASoC: sirf: provide pm-runtime functions when needed
In-Reply-To: <6778119.KeB0KTehn3@wuerfel>
References: <6778119.KeB0KTehn3@wuerfel>
Message-ID: <20140704192857.GF14896@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 05:07:41PM +0200, Arnd Bergmann wrote:
> The newly introduced sirf-usp driver defines sirf_usp_pcm_{suspend,resume}
> functions only when PM_RUNTIME is enabled, but also uses them when that
> is disabled and only PM_SLEEP is turned on, resulting in this error:

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140704/4954dd7a/attachment-0001.sig>

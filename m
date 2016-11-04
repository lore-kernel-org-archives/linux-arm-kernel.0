From: broonie@kernel.org (Mark Brown)
Date: Fri, 4 Nov 2016 11:13:38 -0600
Subject: [PATCH RFC 5/7] ASoC: samsung: pcm: Do not use platform_data for
 DMA parameters
In-Reply-To: <1478276094-19135-7-git-send-email-s.nawrocki@samsung.com>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
 <1478276094-19135-7-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20161104171338.njzghp46o3oxur3c@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2016 at 05:14:52PM +0100, Sylwester Nawrocki wrote:
> All related platforms use either devicetree or the DMA slave
> map API for mapping DMA channels to slave devices so we can now
> stop using platform_data for passing DMA details.

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161104/dde0e7b9/attachment.sig>

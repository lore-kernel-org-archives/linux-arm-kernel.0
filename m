From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jan 2015 19:31:10 +0000
Subject: [PATCH v3 1/2] ASoC: codecs: wm8904: add dt ids table
In-Reply-To: <1422329800-28481-1-git-send-email-voice.shen@atmel.com>
References: <1422329800-28481-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20150128193110.GI21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 11:36:39AM +0800, Bo Shen wrote:
> From: Alexander Morozov <linux@meltdown.ru>
> 
> The WM8904 and WM8918 has the same data type, while the WM8912
> has different data type. So, use the data in dt ids table to
> distinguish them.

Applied both, thanks - please use subjct lines matching the style for
the subsystem and CC maintainers (including driver maintainers).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/0ff467e4/attachment.sig>

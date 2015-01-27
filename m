From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Jan 2015 18:49:10 +0000
Subject: [alsa-devel] [PATCH v4 2/3] ASoC: samsung: Document Trats2 audio
 subsystem bindings
In-Reply-To: <1421989410-12490-3-git-send-email-ideal.song@samsung.com>
References: <1421989410-12490-1-git-send-email-ideal.song@samsung.com>
 <1421989410-12490-3-git-send-email-ideal.song@samsung.com>
Message-ID: <20150127184910.GL21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 02:03:29PM +0900, Inha Song wrote:

> + - samsung,audio-routing : A list of the connections between audio
> +   components. each entry is a pair of strings, the first being the
> +   connection's sink, the second being the connection's source

The list of valid components should be specified here - reference the
CODEC bindings for anything on the CODEC but things on the board need to
be enumerated.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/862c6c22/attachment-0001.sig>

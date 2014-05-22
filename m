From: broonie@kernel.org (Mark Brown)
Date: Thu, 22 May 2014 19:46:56 +0100
Subject: [PATCH 1/2] doc: dt bindings: Document Odroid X2/U3 audio
 subsystem bindings
In-Reply-To: <1400759708-25831-1-git-send-email-s.nawrocki@samsung.com>
References: <1400759708-25831-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20140522184656.GS12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 22, 2014 at 01:55:07PM +0200, Sylwester Nawrocki wrote:

> +	sound {
> +		compatible = "samsung,odroidx2-audio";
> +		samsung,i2s-controller = <&i2s0>;
> +		samsung,audio-codec = <&max98090>;
> +	};

Can this not use simple-card?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140522/06268119/attachment.sig>

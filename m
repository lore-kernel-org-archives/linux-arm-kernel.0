From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 16 Nov 2009 21:33:27 +0800
Subject: [RFC][PATCH] Add interrupt handling capability to pca953x
In-Reply-To: <20091115175550.68964c72@taxman.wild-wind.fr.eu.org>
References: <20091115175550.68964c72@taxman.wild-wind.fr.eu.org>
Message-ID: <f17812d70911160533g175476ebraeaf7f56c48ac2cf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2009 at 12:55 AM, Marc Zyngier <maz@misterjones.org> wrote:
> Most of the GPIO expanders controlled by the pca953x driver are
> able to report changes on the input pins through an *INT pin.
>
> This patch implements a very basic way for the platform code to
> be alerted when some input changes (both edge detection).
> It can be seen as a poor man irq_chip.
>
> Alternatively, this could be turned into a full-fledged irq_chip,
> though I'm not sure it is worth the complexity.
>

This actually has been submitted to the ML half a years ago along with
the first pca953x patch. I believe David Brownell has comments on
this, though :-)

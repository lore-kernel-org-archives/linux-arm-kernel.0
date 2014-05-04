From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 4 May 2014 13:50:03 -0400
Subject: [PATCH v2 5/9] ASoC: simple-card: Support setting mclk via a
 fixed factor
In-Reply-To: <1399141819-23924-6-git-send-email-andrew@lunn.ch>
References: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
 <1399141819-23924-6-git-send-email-andrew@lunn.ch>
Message-ID: <20140504175003.GX28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 03, 2014 at 08:30:15PM +0200, Andrew Lunn wrote:
> Some platforms require that the codecs mclk is a fixed multiplication
> factor of the audio stream rate. Add a optional property to the
> binding to hold this factor and implement a hw_params() function to
> make use of it.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v1->v2:
> s/factor/fs/g
> ---
>  .../devicetree/bindings/sound/simple-card.txt      |  2 ++
>  sound/soc/generic/simple-card.c                    | 28 ++++++++++++++++++++++
>  2 files changed, 30 insertions(+)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

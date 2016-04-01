From: robh@kernel.org (Rob Herring)
Date: Fri, 1 Apr 2016 12:13:08 -0500
Subject: [PATCH v6 1/3] ASoC: cygnus: Add DT bindings for Broadcom Cygnus
 audio
In-Reply-To: <1459383886-20317-2-git-send-email-simran.rai@broadcom.com>
References: <1459383886-20317-1-git-send-email-simran.rai@broadcom.com>
 <1459383886-20317-2-git-send-email-simran.rai@broadcom.com>
Message-ID: <20160401171308.GA7095@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2016 at 05:24:44PM -0700, Simran Rai wrote:
> From: Simran Rai <ssimran@broadcom.com>
> 
> Add bindings for audio driver in Broadcom Cygnus.
> 
> Signed-off-by: Lori Hikichi <lhikichi@broadcom.com>
> Signed-off-by: Simran Rai <ssimran@broadcom.com>
> Reviewed-by: Ray Jui <rjui@broadcom.com>
> Reviewed-by: Scott Branden <sbranden@broadcom.com>
> ---
>  .../bindings/sound/brcm,cygnus-audio.txt           |   67 ++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt

Acked-by: Rob Herring <robh@kernel.org>

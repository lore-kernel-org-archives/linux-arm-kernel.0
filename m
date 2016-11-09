From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Nov 2016 12:24:28 -0600
Subject: [PATCH v2 5/7] ARM: shmobile: Document DT bindings for CCCR and
 PRR
In-Reply-To: <1477913455-5314-6-git-send-email-geert+renesas@glider.be>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
 <1477913455-5314-6-git-send-email-geert+renesas@glider.be>
Message-ID: <20161109182428.lgwo4rqfxelibl3h@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2016 at 12:30:53PM +0100, Geert Uytterhoeven wrote:
> Add device tree binding documentation for the Common Chip Code Register
> and Product Register, which provide SoC product and revision
> information.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - New.
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>

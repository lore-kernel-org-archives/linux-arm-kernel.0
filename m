From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 19 Mar 2018 11:13:01 -0300
Subject: [PATCH] arm: dts: hummingboard2: convert onboard audio to
 simple-audio-card
In-Reply-To: <20180319135326.24357-1-mporter@konsulko.com>
References: <20180319135326.24357-1-mporter@konsulko.com>
Message-ID: <CAOMZO5Dq3hWXKNBwqM7zFW-FjwBGLAsUJnSaUNPXO5kg=iaaGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 10:53 AM, Matt Porter <mporter@konsulko.com> wrote:
> The HB2 onboard audio currently makes use of the imx-audio-sgtl5000
> binding. This binding does not support auxiliary audio devices such
> as external amplifiers. The simple-audio-card binding does support
> this property which allows systems incorporating the HB2 to easily
> add an auxiliary device that's attached to the HB2 audio jack with
> an overlay. Convert HB2 to use simple-audio-card for the onboard
> audio to allow for this additional flexibility.
>
> Signed-off-by: Matt Porter <mporter@konsulko.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

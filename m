From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Jun 2015 09:16:38 -0300
Subject: [PATCH] ARM: dts: imx6qdl-sabreauto: Add HDMI support
In-Reply-To: <CAOMZO5C1D05JYU-3kc9KDW5bf1YiS9+_CfipV54uzpUJCfaKBg@mail.gmail.com>
References: <1433277693-10767-1-git-send-email-festevam@gmail.com>
 <20150629114709.GL10332@tiger>
 <CAOMZO5C1D05JYU-3kc9KDW5bf1YiS9+_CfipV54uzpUJCfaKBg@mail.gmail.com>
Message-ID: <CAOMZO5A0+S_q3WNbXEPZ3K0Yr=ea_dYe=WvgAKtdwFqqH6WhAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 29, 2015 at 8:55 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Jun 29, 2015 at 8:47 AM, Shawn Guo <shawnguo@kernel.org> wrote:
>> On Tue, Jun 02, 2015 at 05:41:33PM -0300, Fabio Estevam wrote:
>>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>>
>>> Add HDMI support. As the DDC I2C pins are not connected due to
>>> pin conflicts, we do not pass the 'ddc-i2c-bus' property in
>>> this case.
>>
>> HDMI works without 'ddc-i2c-bus' property and I2C pins?  If not, what's
>> point of this patch.
>
> Yes, HDMI works fine without 'ddc-i2c-bus' property.
>
> 'ddc-i2c-bus' property is not mandatory to get HDMI functional.

You can also refer to
Documentation/devicetree/bindings/drm/imx/hdmi.txt, which states that
ddc-i2c-bus is an optional property.

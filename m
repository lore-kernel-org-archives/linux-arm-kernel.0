From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 17 May 2017 15:40:26 -0300
Subject: imx7: mmc_select_hs200 failed, error -74
In-Reply-To: <a548e1627b3a18382958fc66a3829289@agner.ch>
References: <CAOMZO5ByTR1C4qUdc+hBcGTFVf-NH2gS5PmH3=w5-TrAoDQVUA@mail.gmail.com>
 <CAOMZO5AXb3-YGc7hGRP_OY8C-Go0pBECbDoQo1SUB1i=t1Xi4w@mail.gmail.com>
 <AM4PR0401MB232411A003DC9F9D2F9CAEA490E70@AM4PR0401MB2324.eurprd04.prod.outlook.com>
 <CAOMZO5BeE_Lm+VM8d9TKv0b21cL6dVNYgBai3wBjjm=bssXWCA@mail.gmail.com>
 <a548e1627b3a18382958fc66a3829289@agner.ch>
Message-ID: <CAOMZO5D8bixZD9TtBpCv5fOvBq=ArpWicKOno_9Dw6vPCgBXYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Wed, May 17, 2017 at 3:23 PM, Stefan Agner <stefan@agner.ch> wrote:

> E.g. mark that it is only 3.3V capable (no-1-8-v) and maybe other
> capabilities (see Documentation/devicetree/bindings/mmc/mmc.txt).

Passing 'no-1-8-v' to the dts did the trick, thanks!

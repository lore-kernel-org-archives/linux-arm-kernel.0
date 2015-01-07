From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 Jan 2015 09:44:37 -0200
Subject: LCD support on mx25
Message-ID: <CAOMZO5BRk_A4=0=xgbXysbE6ZepRozp7HPPZxZci3_aqq1NwAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

In order to convert mx25 into a dt-only platform the only missing
piece is to add LCD support for imx25-pdk.dts.

I have tried it and it is not working for me. Also, when I try the
non-dt mx25pdk the LCD is also not functional anymore. I know the
hardware is fine because LCD works with FSL kernel. I haven't started
any bisect work yet.

Eric/Dennis,

I am wondering if imx25-eukrea-mbimxsd25 boards has LCD functional
with a 3.19-rc kernel? Could you please confirm?

Thanks,

Fabio Estevam

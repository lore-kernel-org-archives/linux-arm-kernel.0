From: jan.tuerk@emtrion.com (Jan Tuerk)
Date: Thu, 23 Nov 2017 13:55:50 +0100
Subject: [PATCH 0/5] Add basic support for emtrion emCON-MX6 modules
Message-ID: <20171123125600.41562-1-jan.tuerk@emtrion.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch-series adds support for emtrion's emCON-MX6 modules
with all their dependencies. The focus is based on the emtion standard
developer-kit configuration. It includes a new vendor-prefix,
an new simple-panel type, a small modification of the imx6dl.dtsi,
as well as modifications of the common imx_v6_v8_defconfig.
And finally the board devicetrees themselves.


emtrion GmbH
Kreativpark - Alter Schlachthof 45
76131 Karlsruhe
GERMANY
http://www.emtrion.de
_______________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
_______________________________________

From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Sat, 03 Oct 2015 14:38:54 +0200
Subject: [PATCH v4 12/26] ARM: pxa: magician: Rename charger cable
 detection EGPIOs
In-Reply-To: <5609B1F8.8070104@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz> <5609B1F8.8070104@tul.cz>
Message-ID: <1443875934.4186.27.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 28.09.2015, 23:32 +0200 schrieb Petr Cvek:
> This patch renames EGPIOs, which are used for the charging cable
> presence
> and type detection. Old names did not correspond with an observed
> functionality (on board_id 0x3a). The behavior is not:
> 
> - AC charger
> - USB charger
> - Cable detection
> 
> , but:
> 
> - AC/USB type
> - Cable detection1
> - Cable detection2
> 
> This patch fixes a possible typo in the bit offset for the cable
> detection
> EGPIO declaration, too.
> 
> Signed-off-by: Petr Cvek <petr.cvek@tul.cz>

Just to be sure, please tell me what are the values of those three
EGPIOs while
  a) wall plug charger plugged in
  b) usb cable connected to a host plugged in
  c) no cable plugged in

It could well be there are differences between our boards.

regards
Philipp

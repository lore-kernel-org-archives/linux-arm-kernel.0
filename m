From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Fri,  8 Nov 2013 14:48:39 +0100
Subject: [PATCH 0/2] ARM: i.MX28: define various external xtal frequencies in
 DT
Message-ID: <1383918521-4668-1-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

this patch pushes the definition for the external 24m and 32k crystals to the
DT. The kernel should continue to work on DT that don't define the 24m clock,
the standard 24MHz are assumed.

regards,
Marc

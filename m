From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Sun, 20 Mar 2011 21:30:00 +0100
Subject: [PATCH v3 0/9] Support for NXP LPC2K SoCs
Message-ID: <1300653009-11675-1-git-send-email-ithamar.adema@team-embedded.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch series implements support for the ARM7TDMI-S based
NXP LPC2K System-on-Chips, and, as first board, the EmbeddedArtists
LPC2478 Developer's Kit.

This code will work on the LPC23XX and LPC24XX ranges of chips, but will
need some more work for LPC21XX and LPC22XX chips.
---
v3 incorporates comments from Russell King and Kevin Wells.

v2 incorporates comments from Kevin Wells, Jamie Iles,
and Uwe Kleine-K??nig.

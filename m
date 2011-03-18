From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Fri, 18 Mar 2011 16:11:47 +0100
Subject: [PATCH v2 0/9] Support for NXP LPC2K SoCs
Message-ID: <1300461116-6028-1-git-send-email-ithamar.adema@team-embedded.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch series implements support for the ARM7TDMI-S based
NXP LPC2K System-on-Chips, and, as first board, the EmbeddedArtists
LPC2478 Developer's Kit.

This code will work on the LPC23XX and LPC24XX ranges of chips, but will
need some more work for LPC21XX and LPC22XX chips.
---
v2 incorporates the comments from Kevin Wells, Jamie Iles,
and Uwe Kleine-K??nig.

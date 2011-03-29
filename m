From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Tue, 29 Mar 2011 12:30:46 +0200
Subject: [PATCH v4 0/10] Support for NXP LPC2K SoCs
Message-ID: <1301394656-24853-1-git-send-email-ithamar.adema@team-embedded.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patch series implements support for the ARM7TDMI-S based
NXP LPC2K System-on-Chips, and, as first board, the EmbeddedArtists
LPC2478 Developer's Kit.

This code will work on the LPC23XX and LPC24XX ranges of chips, but will
need some more work for LPC21XX and LPC22XX chips.
---
v4 incorporates comments from Kevin Wells. Also included is a NOMMU patch
taken from http://lkml.org/lkml/2011/3/25/430 which is just included to
keep this patch set buildable.

v3 incorporates comments from Russell King and Kevin Wells.

v2 incorporates comments from Kevin Wells, Jamie Iles,
and Uwe Kleine-K?nig.

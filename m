From: apatard@mandriva.com (apatard at mandriva.com)
Date: Tue, 25 May 2010 14:22:36 +0200
Subject: [patch 0/5] kirkwood openrd client audio support - v3
Message-ID: <20100525122236.841941526@mandriva.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

It's a new try to get merged kirkwood openrd client support.

The changes are :
- set window configuration according to dma address
- namespaced all cs42l51 #define
- modified cs42l51_dac_names array according to what proposed Mark Brown
- use SOC_DOUBLE_TLV for mic boost

Arnaud

From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Thu,  6 Dec 2012 16:42:47 -0600
Subject: [PATCH 0/6 v9] cpufreq: add support for Calxeda ECX-1000 (highbank)
In-Reply-To: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
Message-ID: <1354833773-22845-1-git-send-email-mark.langsdorf@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds cpufreq support for the Calxeda
ECX-1000 (highbank) SoCs. The EnergyCore Management Engine (ECME) on
the ECX-1000 manages the voltage for the part and communications with
Linux through a pl320 mailbox. clk notifications are used to control
when to send messages to the ECME.

--Mark Langsdorf
Calxeda, Inc.

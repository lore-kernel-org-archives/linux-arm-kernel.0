From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Fri, 25 Jan 2013 13:46:41 -0600
Subject: [PATCH 0/4 v11] cpufreq: add support for Calxeda ECX-1000 (highbank)
In-Reply-To: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
Message-ID: <1359143205-20279-1-git-send-email-mark.langsdorf@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds cpufreq support for the Calxeda
ECX-1000 (highbank) SoCs. The EnergyCore Management Engine (ECME) on
the ECX-1000 manages the voltage for the part and communications with
Linux through a pl320 mailbox. clk notifications are used to control
when to send messages to the ECME.

Previous versions of this patch set include two other patches. One has
been dropped as unworkable and the other turned out to be unnecessary.

--Mark Langsdorf
Calxeda, Inc.

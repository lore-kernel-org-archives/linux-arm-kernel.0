From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Fri,  4 Jan 2013 10:35:42 -0600
Subject: [PATCH 0/4 v10] cpufreq: add support for Calxeda ECX-1000 (highbank)
In-Reply-To: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
Message-ID: <1357317346-1120-1-git-send-email-mark.langsdorf@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds cpufreq support for the Calxeda
ECX-1000 (highbank) SoCs. The EnergyCore Management Engine (ECME) on
the ECX-1000 manages the voltage for the part and communications with
Linux through a pl320 mailbox. clk notifications are used to control
when to send messages to the ECME.

Previous versions of this patch set include two other patches. One has
been dropped as unworkable and the other got picked up and included in
3.8.0.

--Mark Langsdorf
Calxeda, Inc.

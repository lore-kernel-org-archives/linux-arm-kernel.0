From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Tue, 27 Nov 2012 09:04:31 -0600
Subject: [PATCH 3/6 v5] cpufreq: tolerate inexact values when collecting stats
In-Reply-To: <1354028674-23685-1-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354028674-23685-1-git-send-email-mark.langsdorf@calxeda.com>
Message-ID: <1354028674-23685-4-git-send-email-mark.langsdorf@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is withdrawn due to a need for severe rework.

Changes from v4
	Withdrawn.	
Changes from v3, v2
        None.
Changes from v1
        Implemented a simple round-up algorithm instead of the over/under
method that could cause errors on Intel processors with boost mode.

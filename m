From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Wed,  5 Dec 2012 10:48:38 -0600
Subject: [PATCH 3/6 v8] cpufreq: tolerate inexact values when collecting stats
In-Reply-To: <1354726121-17190-1-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354726121-17190-1-git-send-email-mark.langsdorf@calxeda.com>
Message-ID: <1354726121-17190-4-git-send-email-mark.langsdorf@calxeda.com>
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

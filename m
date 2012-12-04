From: mark.langsdorf@calxeda.com (Mark Langsdorf)
Date: Tue,  4 Dec 2012 08:33:59 -0600
Subject: [PATCH 3/6 v7] cpufreq: tolerate inexact values when collecting stats
In-Reply-To: <1354631642-30433-1-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354631642-30433-1-git-send-email-mark.langsdorf@calxeda.com>
Message-ID: <1354631642-30433-4-git-send-email-mark.langsdorf@calxeda.com>
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

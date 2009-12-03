From: tero.kristo@nokia.com (Tero Kristo)
Date: Thu,  3 Dec 2009 15:35:51 +0200
Subject: [PATCHv2 0/2] VFP context save/restore for OMAP3
In-Reply-To: <>
References: <>
Message-ID: <1259847353-22725-1-git-send-email-tero.kristo@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <tero.kristo@nokia.com>

Contains following fixes compared to previous version:

- vfp_pm_suspend uses the same routine as context save
- uses get_cpu / put_cpu to get current CPU id
- removed restore context call completely from OMAP3 idle (not needed)

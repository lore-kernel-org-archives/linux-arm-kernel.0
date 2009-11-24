From: tero.kristo@nokia.com (Tero Kristo)
Date: Tue, 24 Nov 2009 12:37:02 +0200
Subject: [PATCH 0/2] VFP save/restore for OMAP3
In-Reply-To: <>
References: <>
Message-ID: <1259059024-23719-1-git-send-email-tero.kristo@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tero Kristo <tero.kristo@nokia.com>

Hi,

The following two patches are needed by OMAP3 to save/restore VFP context
during off-mode. Patch 1 adds generic support inside ARM VFP code, and the
second one adds the necessary hooks into OMAP3 power management code.

--Tero

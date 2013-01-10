From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 10 Jan 2013 17:22:27 +0400
Subject: [PATCH 1/2] Fix phy_init for Marvell network eth driver
In-Reply-To: <1357819234-27752-2-git-send-email-konszert@marvell.com>
References: <1357819234-27752-1-git-send-email-konszert@marvell.com>
 <1357819234-27752-2-git-send-email-konszert@marvell.com>
Message-ID: <50EEC093.4080505@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10-01-2013 16:00, Kosta Zertsekel wrote:

> At least it fixes DNS323_REV_C1 board case (mach-orion5x/dsn323-setup.c file).

> Change-Id: I37d64795f79c358f66a211a150cec2263e40e295

    This line has no place in the upstream commit, please remove it. Also, the 
patch misses your signoff, so  couldn't be applied anyway. Same about the next 
patch.

WBR, Sergei

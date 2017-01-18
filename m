From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 18 Jan 2017 20:06:02 +0300
Subject: [PATCH] ARM: shmobile: r8a7779: marzen: Fix sata device status
In-Reply-To: <1484585813-22534-1-git-send-email-geert+renesas@glider.be>
References: <1484585813-22534-1-git-send-email-geert+renesas@glider.be>
Message-ID: <8b298878-672b-74fe-5196-99f8620889ac@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2017 07:56 PM, Geert Uytterhoeven wrote:

> Device nodes representing I/O devices should be marked disabled in the
> SoC-specific DTS, and overridden by board-specific DTSes where needed.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

    Simon, I'm seeing this commit in the 'devel' branch but not seeing the new 
tag containing it... forgot to tag/push?

MBR, Sergei

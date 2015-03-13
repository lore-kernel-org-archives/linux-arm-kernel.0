From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Mar 2015 20:56:58 +0100
Subject: [PATCH 00/12] Remove mach-msm and associated code
In-Reply-To: <3936339.LqGDoxnsbi@wuerfel>
References: <1426270185-19510-1-git-send-email-sboyd@codeaurora.org>
 <3936339.LqGDoxnsbi@wuerfel>
Message-ID: <53452172.fMbGZpu3Vz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 March 2015 20:55:30 Arnd Bergmann wrote:
> 
> I think the MMC driver should also be removed when the platform
> code is deleted, new code would use the mmci driver anyway.

Nevermind, I now see patch 6/12, which does just this.

	Arnd

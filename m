From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 May 2016 23:09:38 +0200
Subject: [PATCH 0/6] Support BCM23550 SoC
In-Reply-To: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
References: <1462481334-8943-1-git-send-email-chris.brand@broadcom.com>
Message-ID: <6872671.Czyv7J9iJZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 May 2016 13:48:48 Chris Brand wrote:
> This patchset introduces support for the BCM23550 SoC and the Broadcom
> Sparrow development board.
> 
> It modifies the BCM21664 support slightly to share code between the two.
> 
> With this patchset, a multi-v7 kernel brings up all 4 CPUs on a Sparrow
> board, and gets to a shell prompt. Many of the IP blocks that are shared
> with BCM28155 and BCM21664 are also functional, although not all have
> been thoroughly tested.

Looks really nice overall, I only found one tiny detail I commented on
for patch 6.

I'm glad to see work on the old chips resume, are you working on new
code for it as well, or just upstreaming the patches that were already
done in the past?

	Arnd

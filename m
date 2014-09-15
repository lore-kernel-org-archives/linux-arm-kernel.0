From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 15 Sep 2014 18:52:07 +0200
Subject: [PATCH 0/2] ARM: at91: Further PIT improvements
In-Reply-To: <1410789744-23975-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1410789744-23975-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <201409151852.08178.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 15 September 2014, Maxime Ripard wrote:
> These patches are meant to address Arnd comments and are based on
> Nicolas' at91-3.18-drivers2 branch.
> 
> They basically just remove the early_platform devices, and keep the
> old mechanism with a function exported by the PIT timer and called by
> the board files.
> 


Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 21 May 2013 09:45:36 -0400
Subject: [PATCH 3/9] arm: mvebu: mark functions of armada-370-xp.c as
 static
In-Reply-To: <1369132414-18959-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1369132414-18959-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130521134536.GT31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 21, 2013 at 12:33:28PM +0200, Thomas Petazzoni wrote:
> All the functions in armada-370-xp.c are called from the
> DT_MACHINE_START function pointers, so there is no need for them to be
> visible outside of this file, and we therefore mark them as static.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/mach-mvebu/armada-370-xp.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to mvebu/cleanup

thx,

Jason.

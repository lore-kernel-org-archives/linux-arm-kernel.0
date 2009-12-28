From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 28 Dec 2009 22:14:55 +0100
Subject: [PATCH 4/7] [ARM] locomo: allow cascaded IRQ base to be
	specified by platforms
In-Reply-To: <1261977488-18271-5-git-send-email-eric.y.miao@gmail.com>
References: <1261977488-18271-1-git-send-email-eric.y.miao@gmail.com>
	<1261977488-18271-5-git-send-email-eric.y.miao@gmail.com>
Message-ID: <20091228211455.GA1612@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2009-12-28 13:18:05, Eric Miao wrote:
> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> ---
>  arch/arm/common/locomo.c                 |   49 +++++++++++++++++-------------
>  arch/arm/include/asm/hardware/locomo.h   |    4 ++
>  arch/arm/mach-pxa/include/mach/irqs.h    |    6 ----
>  arch/arm/mach-pxa/poodle.c               |    7 ++++
>  arch/arm/mach-sa1100/collie.c            |    4 ++
>  arch/arm/mach-sa1100/include/mach/irqs.h |   11 +-----
>  6 files changed, 45 insertions(+), 36 deletions(-)

How was this tested? Maybe ccing thomas would be good idea?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

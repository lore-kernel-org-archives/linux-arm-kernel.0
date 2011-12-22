From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Thu, 22 Dec 2011 18:15:11 +0200
Subject: [PATCH 02/10] arm: vexpress: fix kconfig warning
In-Reply-To: <20111222113916.GA2625@localhost>
References: <1324341747-5922-1-git-send-email-felipe.contreras@gmail.com>
 <1324341747-5922-3-git-send-email-felipe.contreras@gmail.com>
 <20111222113916.GA2625@localhost>
Message-ID: <CAMP44s3qhLNRv6e7GJY-pGigv-fqeFZw1zfqOqHThL0nV5tegg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 22, 2011 at 1:39 PM, Dave Martin <dave.martin@linaro.org> wrote:
> NAK -- I hit this problem too, but in fact the errata configs should not
> really be dependent on SMP; these are fixed in a couple of patches
> currently queued in Russell's patch system:
>
> 7196/1 - errata: remove SMP dependency for erratum 720789
> 7197/1 - errata: remove SMP dependency for erratum 751472
>
> ...so we should avoid duplicating knowledge about exactly what these
> errata workarounds do, where it can be avoided.
>
> In the meantime, the warning is harmless.

All right.

-- 
Felipe Contreras

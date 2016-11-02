From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 02 Nov 2016 22:45:18 +0100
Subject: [PATCH v2] ARM: pxa: remove duplicated include from spitz.c
In-Reply-To: <1477742190-3300-1-git-send-email-robert.jarzmik@free.fr> (Robert
 Jarzmik's message of "Sat, 29 Oct 2016 13:56:30 +0200")
References: <1477742190-3300-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87h97pzhch.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> From: Wei Yongjun <weiyj.lk@gmail.com>
>
> This partially reverts commit 12beb346710b ("Merge tag 'pxa-fixes-v4.8'
> of https://github.com/rjarzmik/linux into randconfig-4.8").
>
> This former patch introduced accidentally a double include of module.h.
>
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> Acked-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> [amended commit message and 2 comments]
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Queued to pxa/for-next.

--
Robert

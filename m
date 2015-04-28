From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 28 Apr 2015 21:36:10 +0200
Subject: [PATCH v2 15/17] ARM: pxa: poodle: don't preallocate IRQ space
 for locomo
In-Reply-To: <1430178954-11138-16-git-send-email-dbaryshkov@gmail.com> (Dmitry
 Eremin-Solenikov's message of "Tue, 28 Apr 2015 02:55:52 +0300")
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-16-git-send-email-dbaryshkov@gmail.com>
Message-ID: <87618gjb9x.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> As new locomo driver supports SPARSE_IRQ, don't preallocate NR_IRQS
> space for it on poodle.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert

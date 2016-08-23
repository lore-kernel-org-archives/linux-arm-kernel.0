From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 23 Aug 2016 18:24:54 +0200
Subject: [PATCH -next] ARM: pxa: remove duplicated include from spitz.c
In-Reply-To: <1471965498-7824-1-git-send-email-weiyj.lk@gmail.com> (Wei
 Yongjun's message of "Tue, 23 Aug 2016 15:18:18 +0000")
References: <1471965498-7824-1-git-send-email-weiyj.lk@gmail.com>
Message-ID: <87y43npi5l.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wei Yongjun <weiyj.lk@gmail.com> writes:

> Remove duplicated include.
How so duplicated ? Can you elaborate please ?

Moreover, how do you do think symbol_get() can stay in spitz.c without having
this include ?

Cheers.

--
Robert

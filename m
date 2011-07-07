From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 7 Jul 2011 10:02:17 +0100
Subject: [PATCH] remove unnecessary cache flush on v6 copypage
In-Reply-To: <CAN_5kQDTweB2GLvwgjN+BQuqnhFUp+MOcQr=ZW=8C6XSsC8XtA@mail.gmail.com>
References: <CAN_5kQDTweB2GLvwgjN+BQuqnhFUp+MOcQr=ZW=8C6XSsC8XtA@mail.gmail.com>
Message-ID: <CAHkRjk6WNu5h=QCN-8EfyHHG=0MiX4qbcqHiPws=hgXOf2bvMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 7, 2011, heechul Yun <heechul@illinois.edu> wrote:
> ARM: mm: remove unnecessary cache flush on v6 copypage
>
> Signed-off-by: Heechul Yun <heechul@illinois.edu>

I would clarify the commit log a bit stating that this flush is no
longer necessary because of commit c0177800. We had a good reason for
adding the flush initially.

Otherwise,

Acked-by: Catalin Marinas <catalin.marinas@arm.com>


-- 
Catalin

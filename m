From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 26 Jan 2010 08:44:14 +0100
Subject: measureing kernel & application boottime's
In-Reply-To: <cf70f0211001222331y17af1f56oe7d4e61c1d38d7d3@mail.gmail.com>
References: <cf70f0211001222331y17af1f56oe7d4e61c1d38d7d3@mail.gmail.com>
Message-ID: <63386a3d1001252344u3ff7bb12q97ee65da13b69a9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/1/23 Shivdas Gujare <shivdas.tech@gmail.com>:

> I am trying to measure kernel boottime along with measuring
> application process start time on ARM V6 platform.
> Because of few reasons, I have to stick to kernel 2.6.25(can't upgrade
> it to latest).
(...)
> Also, Is there any best method to measure application start time
> (except bootchart, can't use it)?

Upgrade anyway. Seriously. It's for your own good. The best way to get
a bootchart without bootchart is to backport bootchart to kernel 2.6.25
and then the best strategy to do that is likely to upgrade to kernel 2.6.32
and rename it 2.6.25 and say it's a backport of the entire 2.6.32 to 2.6.25 :-P

Yours,
Linus Walleij

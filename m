From: kmpark@infradead.org (Kyungmin Park)
Date: Tue, 18 May 2010 08:59:29 +0900
Subject: Samsung SoCs framebuffer re-work
Message-ID: <AANLkTinThrLrsxBYHs-1xPqIaRiK1HH-YZkcloKHnzkx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

Currently there's only one fb drivers for samsung SocS. but it's based
on s3c24xx and a part of s3c64xx.
As you can see the s5pc110 (aka s5pv210) spec, It has more features
and interconnection between FIMC and FIMD.
So current fb driver can't handle these features well. So LSI make a
own fb drivers and use it. You can see the code at their git repo.

Now we are re-implement or change it for s5pc110 and for future usages.
How do you think?

Thank you,
Kyungmin Park

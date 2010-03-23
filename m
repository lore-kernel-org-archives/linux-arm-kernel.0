From: 914059751@qq.com (=?gbk?B?uvrR7sr3?=)
Date: Tue, 23 Mar 2010 21:41:48 +0800
Subject: Query about Float Point Operation
Message-ID: <tencent_294E932A6E12E0191CF4271B@qq.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WOW
My audio codec drivers use float point operation heavily!
Does that mean that I can ONLY implement it on USER space ?
 
 
------------------ Original ------------------
From:  "M?ns Rullg?rd"<mans@mansr.com>;
Date:  Tue, Mar 23, 2010 09:34 PM
To:  "linux-arm-kernel"<linux-arm-kernel@lists.infradead.org>; 

Subject:  Re: Query about Float Point Operation

 
914059751 at qq.com writes:

> Hi , guys
> I want to do float point operations in kernel like the following,
>
> int foo(double d)
> {
> return (int)d*d;
> }
>
> May I ask any possibility of use float point operation in the kernel space?

Floating-point in the kernel is not allowed.

-- 
M?ns Rullg?rd
mans at mansr.com


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

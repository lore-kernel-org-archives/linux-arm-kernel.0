From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 23 Mar 2010 13:34:16 +0000
Subject: Query about Float Point Operation
References: <tencent_1612D48D0AEC89DB53D9FFBB@qq.com>
Message-ID: <yw1xpr2v5fhj.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

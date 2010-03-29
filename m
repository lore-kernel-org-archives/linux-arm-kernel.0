From: rkiyerpersonal@gmail.com (Rajanikanth H.V)
Date: Mon, 29 Mar 2010 10:52:50 +0530
Subject: Query about Float Point Operation
In-Reply-To: <tencent_1612D48D0AEC89DB53D9FFBB@qq.com>
References: <tencent_1612D48D0AEC89DB53D9FFBB@qq.com>
Message-ID: <d82162471003282222q5e463306rd385c3ed54879e4d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/3/23 ??? <914059751@qq.com>:
> Hi , guys
> I want to do float point operations in kernel like the following,
>
> int foo(double d)
> {
>
> return (int)d*d;
>
> }
>
> while compiling output error msg like following:
> cannt find eabi_dmul ?balabla??????
>
> May I ask any possibility of use float point operation in the kernel space?
> Any hints/doc would be appreciated!
I do not know how are you compiling the required function.
Use hardware floating point support. If your target SOC support.
Also verify whether Floating Point Emulation -> VFP is enabled in your config.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

From: martinwguy@gmail.com (Martin Guy)
Date: Mon, 29 Mar 2010 11:59:45 +0100
Subject: Query about Float Point Operation
In-Reply-To: <d82162471003282222q5e463306rd385c3ed54879e4d@mail.gmail.com>
References: <tencent_1612D48D0AEC89DB53D9FFBB@qq.com>
	<d82162471003282222q5e463306rd385c3ed54879e4d@mail.gmail.com>
Message-ID: <56d259a01003290359r29808e09p69d7fc8a0c4fa015@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/29/10, Rajanikanth H.V <rkiyerpersonal@gmail.com> wrote:
> 2010/3/23 ??? <914059751@qq.com>:
>  > Hi , guys
>  > I want to do float point operations in kernel like the following,
>  >
>  > int foo(double d)
>  > {
>  >
>  > return (int)d*d;
>  >
>  > }
>  >
>  > while compiling output error msg like following:
>  > cannt find eabi_dmul  balabla??????
>  >
>  > May I ask any possibility of use float point operation in the kernel space?
>  > Any hints/doc would be appreciated!
>  I do not know how are you compiling the required function.
>  Use hardware floating point support. If your target SOC support.
>  Also verify whether Floating Point Emulation -> VFP is enabled in your config.

Wrong. You cannot do floating point operations inside the linux kernel.
At best, you can use fixed-point arithmetic.

    M

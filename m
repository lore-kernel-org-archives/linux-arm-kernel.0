From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 May 2014 10:02:41 +0100
Subject: [PATCH 1/1] ARM: ux500: Staticize ux500_soc_attr
In-Reply-To: <CAK9yfHwHO_WPaGqJLVxOZrzFCRqBKi+zJPF2-8cDPokcdkb2dA@mail.gmail.com>
References: <1401248417-10146-1-git-send-email-sachin.kamat@linaro.org>
 <20140528083649.GB10803@lee--X1>
 <CAK9yfHwHO_WPaGqJLVxOZrzFCRqBKi+zJPF2-8cDPokcdkb2dA@mail.gmail.com>
Message-ID: <20140528090241.GC10803@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 28 May 2014 14:06, Lee Jones <lee.jones@linaro.org> wrote:
> > On Wed, 28 May 2014, Sachin Kamat wrote:
> >
> >> 'ux500_soc_attr' is local to this file. While at it also make it
> >> const to match the argument list of device_create_file.
> >
> > What's going on Sachin?  I Acked v2 of this patch an hour ago, yet
> > you've resent it as a v1 and without the Ack?
> 
> Actually I posted v2 twice almost immediately. The first time I forgot to
> CC LKML as requested by you. Sorry for the confusion.

Okay, I see.  Thanks for clarifying.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

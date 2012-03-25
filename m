From: viresh.linux@gmail.com (viresh kumar)
Date: Sun, 25 Mar 2012 13:01:32 +0530
Subject: [PATCH 1/2] ARM: VIC: Create common infrastructure for vic DT
 bindings
In-Reply-To: <4F6C6F32.10800@gmail.com>
References: <4bfe7af3761f6f40506a2089fd67866015f6d7f3.1332488625.git.viresh.kumar@st.com>
 <4F6C6F32.10800@gmail.com>
Message-ID: <CAOh2x=n-sZ6jV1M9XY9cOp7_8EeRfvqkjL5y3AakgpYymFRHkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2012 at 6:10 PM, Rob Herring <robherring2@gmail.com> wrote:
> NAK
>
> None of these platforms have gpio interrupts or any other board
> interrupt controllers which need to be initialized early?

Atleast SPEAr600 have GPIO interrupts.

> I don't think DT conversions are complete enough to tell.

Couldn't get your comment, sorry.

> We could do something like this, but there only needs to be a single
> match list of all controllers and function. We should consolidate the
> irqchips to drivers/irqchip first though. I have that action from Connect...

That would be good.
I am updating DT support for SPEAr3xx, where i need to use VIC OF
support. So i would still like to get this patch going and you can consilidate
code at irqchips level later. What do you say?

--
viresh

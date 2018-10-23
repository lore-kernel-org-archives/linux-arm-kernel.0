From: peron.clem@gmail.com (=?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?=)
Date: Tue, 23 Oct 2018 16:44:32 +0200
Subject: [PATCH] ARM: debug: enable UART1 for socfpga Cyclone5
In-Reply-To: <e761c76d-a806-402a-b25b-04aee9329dbc@kernel.org>
References: <20181009112837.2517-1-peron.clem@gmail.com>
 <e761c76d-a806-402a-b25b-04aee9329dbc@kernel.org>
Message-ID: <CAJiuCceZr8NsDgBJgA2y61VHdQ3JYQ6_3r4jKooKLbVfRD8eJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Dinh,

On Tue, 23 Oct 2018 at 16:04, Dinh Nguyen <dinguyen@kernel.org> wrote:
>
> Hi Cl?ment,
>
> On 10/09/2018 06:28 AM, Cl?ment P?ron wrote:
> > Cyclone5 and Arria10 doesn't have the same memory map for UART1.
> >
> > Split the SOCFPGA_UART1 into 2 options to allow debugging on UART1 for Cylone5.
> >
>
> I'm not sure the need for this patch. Are there any cyclone5 based
> boards that has UART1 as the debug uart? I see that all of them are
> using UART0.

There is no upstream device with this UART used. But the board I have
use it, and there is no limitation to not have it available upstream
no ?

Thanks,
Clement

>
> Dinh
>

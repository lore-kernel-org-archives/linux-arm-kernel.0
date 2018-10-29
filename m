From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 29 Oct 2018 22:04:46 +0900
Subject: [PATCH v3 1/4] x86/mm: declare check_la57_support() as inline
In-Reply-To: <20181028140911.21d49629@vmware.local.home>
References: <20181028130945.23581-1-changbin.du@gmail.com>
 <20181028130945.23581-2-changbin.du@gmail.com>
 <20181028140911.21d49629@vmware.local.home>
Message-ID: <CAK7LNATixykqHqdu5W3NpfXqBXMNsP0OLKjNdsFc_EzJ_diOxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 3:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sun, 28 Oct 2018 13:09:42 +0000
> Changbin Du <changbin.du@gmail.com> wrote:
>
> > The level4_kernel_pgt is only defined when X86_5LEVEL is enabled.
> > So declare check_la57_support() as inline to make sure the code
> > referring to level4_kernel_pgt is optimized out. This is a preparation
> > for CONFIG_CC_OPTIMIZE_FOR_DEBUGGING.
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> -- Steve
>


Applied to linux-kbuild.


-- 
Best Regards
Masahiro Yamada

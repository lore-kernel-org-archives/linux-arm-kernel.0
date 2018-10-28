From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 28 Oct 2018 22:11:27 +0900
Subject: [PATCH v2 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
In-Reply-To: <20181019124921.13780-3-changbin.du@gmail.com>
References: <20181019124921.13780-1-changbin.du@gmail.com>
 <20181019124921.13780-3-changbin.du@gmail.com>
Message-ID: <CAK7LNASAv3OcujS9RssGue-0Nd+zVh+O4jMOOmKQOqdtWWt9Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2018 at 9:50 PM Du Changbin <changbin.du@gmail.com> wrote:
>
> This patch add a new kernel hacking option NO_AUTO_INLINE. Selecting
> this option will prevent the compiler from optimizing the kernel by
> auto-inlining functions not marked with the inline keyword.
>
> With this option, only functions explicitly marked with "inline" will
> be inlined. This will allow the function tracer to trace more functions
> because it only traces functions that the compiler has not inlined.
>
> Signed-off-by: Du Changbin <changbin.du@gmail.com>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>


This subject
"kernel hacking: new config NO_AUTO_INLINE to disable compiler
auto-inline optimizations"
is also too long.

Could you please make it a bit shorter?


-- 
Best Regards
Masahiro Yamada

From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 3 Jul 2016 16:55:49 -0300
Subject: [PATCH v2] clk: imx7d: do not set parent of ethernet time/ref
 clocks
In-Reply-To: <d5ff8c157bf6108afe2b14ae887c7b71@agner.ch>
References: <20160703174813.13970-1-stefan@agner.ch>
 <CAOMZO5AghMZ0iV0=0hBrFhhhAAfPpyxH0oj8UT7TqZr9N0+y9A@mail.gmail.com>
 <d5ff8c157bf6108afe2b14ae887c7b71@agner.ch>
Message-ID: <CAOMZO5AFEGfP+n-TAY-9+BMR7=FKGXkLYxNvFfDk6Hxd9EXL1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 3, 2016 at 3:25 PM, Stefan Agner <stefan@agner.ch> wrote:

> Hm, just checked again, that is really not the case here. On what base
> do you test? I tested on clk-next. Dong's clock changes are a
> prerequisite for that.

Thanks for the clarification. I was testing against linux-next.

After manually applying Dong's clock changes from clk-next + your
patch the warnings go away,
so:

Tested-by: Fabio Estevam <festevam@gmail.com>

Thanks

From: rogershimizu@gmail.com (Roger Shimizu)
Date: Fri, 6 Jan 2017 21:18:15 +0900
Subject: [PATCH v3 2/3] DT: bingdings: power: reset: add linkstation-reset
 doc
In-Reply-To: <20170103170952.7svgaa247ewlht7f@rob-hp-laptop>
References: <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161227070611.14852-1-rogershimizu@gmail.com>
 <20161227070611.14852-3-rogershimizu@gmail.com>
 <20170103170952.7svgaa247ewlht7f@rob-hp-laptop>
Message-ID: <CAEQ9gEkGKHXEqjcuR6nrV5XpLRvCFhaONjpPkeCx46ygD0K1UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Rob,

Thanks for your comments!

On Wed, Jan 4, 2017 at 2:09 AM, Rob Herring <robh@kernel.org> wrote:
>
> This needs to model the uC connected to the UART rather than some node
> that defines only some portion of the functionality. I'm working on
> bindings and proper bus support for this[1], but it's not done yet.
> Though, the binding side is pretty simple.
>
> Rob
>
> [1] https://git.kernel.org/cgit/linux/kernel/git/robh/linux.git/log/?h=serial-bus-v2

Actually I have limited knowledge on DT binding.
I think it should be OK to remove the 2/3 patch (this thread) in my
next series, and I'll do my homework when you finish it.
Thank you!

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1

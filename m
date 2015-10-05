From: horms@verge.net.au (Simon Horman)
Date: Mon, 5 Oct 2015 12:03:55 +0900
Subject: [PATCH] ARM: shmobile: fix SILK board name
In-Reply-To: <6818713.ulHphNVRsJ@wasted.cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <6818713.ulHphNVRsJ@wasted.cogentembedded.com>
Message-ID: <20151005030355.GD29979@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 03, 2015 at 12:53:38AM +0300, Sergei Shtylyov wrote:
> Unfortunately, the SILK board bindings were not quite correct, as the  board
> name should be all caps.  Fix that,  adding the board model #  in parens and
> removing stray semicolon.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks, I have queued this up.

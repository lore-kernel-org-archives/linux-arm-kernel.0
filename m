From: olof@lixom.net (Olof Johansson)
Date: Fri, 7 Sep 2012 15:19:52 -0700
Subject: [PATCH v2 RESEND] ARM: Build dtb files in all target
In-Reply-To: <20120907145701.GB19437@titan.lakedaemon.net>
References: <1346691487-17534-1-git-send-email-andrew@lunn.ch>
 <20120907145701.GB19437@titan.lakedaemon.net>
Message-ID: <20120907221952.GA4428@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 10:57:01AM -0400, Jason Cooper wrote:
> On Mon, Sep 03, 2012 at 06:58:07PM +0200, Andrew Lunn wrote:
> > Tools like kisskb are good at finding build regressions in the kernel
> > sources. However, regressions in the DT desscriptions are not found,
> > because generally these build systems don't build the DT binary blobs.
> > 
> > Extend the ARM all target to build all enabled DTB files.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > Acked-by: Jason Cooper <jason@lakedaemon.net>
> > Reviewed-by: Dave Martin <dave.martin@linaro.org>
> 
> Arnd, Olof,
> 
> Is it appropriate to take this directly into your tree or should it go
> through Russell's?

Please send it to Russell's patch tracker, and feel free to add my:

Acked-by: Olof Johansson <olof@lixom.net>


-Olof

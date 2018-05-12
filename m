From: gregkh@linux-foundation.org (Greg KH)
Date: Sat, 12 May 2018 06:31:35 +0200
Subject: [BUGFIX PATCH v3 0/4] arm: kprobes: Fix to prohibit probing on
 unsafe functions
In-Reply-To: <20180512094221.e911fa262d8ca9a70ab8869e@kernel.org>
References: <152540727123.29650.13679359124038587629.stgit@devbox>
 <20180508112503.GD16141@n2100.armlinux.org.uk>
 <20180512094221.e911fa262d8ca9a70ab8869e@kernel.org>
Message-ID: <20180512043135.GA23663@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 12, 2018 at 09:42:21AM +0900, Masami Hiramatsu wrote:
> Hi Greg,
> 
> Could you pick this series to stable?

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

thanks,

greg k-h

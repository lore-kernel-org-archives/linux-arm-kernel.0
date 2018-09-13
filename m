From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 13 Sep 2018 09:12:16 +0200
Subject: [4.14.y] request commit 94a5d8790e79 ("arm64: cpu_errata:
 include required headers")
In-Reply-To: <20180911170030.650928d8@xhacker.debian>
References: <20180911170030.650928d8@xhacker.debian>
Message-ID: <20180913071216.GH11496@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 05:00:30PM +0800, Jisheng Zhang wrote:
> Hi Greg,
> 
> I think we missed the commit 94a5d8790e79 ("arm64: cpu_errata: include
> required headers"), could you please include it in next stable release?

Really, you are seeing build failures on 4.14.y without this patch
applied?  I haven't gotten any reports of this, what is wrong with our
build tests that this isn't being caught?

thanks,

greg k-h

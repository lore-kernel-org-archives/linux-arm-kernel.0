From: greg@kroah.com (Greg KH)
Date: Mon, 6 Sep 2010 14:10:54 -0700
Subject: [RFCv5 8/9] mm: vcm: Sample driver added
In-Reply-To: <262a5a5019c1f1a44d5793f7e69776e56f27af06.1283749231.git.mina86@mina86.com>
References: <cover.1283749231.git.mina86@mina86.com>
	<262a5a5019c1f1a44d5793f7e69776e56f27af06.1283749231.git.mina86@mina86.com>
Message-ID: <20100906211054.GC5863@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 06, 2010 at 08:33:58AM +0200, Michal Nazarewicz wrote:
> --- /dev/null
> +++ b/include/linux/vcm-sample.h

Don't put "sample" code in include/linux/ please.  That's just
cluttering up the place, don't you think?  Especially as no one else
needs the file there...

thanks,

greg k-h

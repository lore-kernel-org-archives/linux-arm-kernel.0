From: greg@kroah.com (Greg KH)
Date: Mon, 2 May 2011 16:38:52 -0700
Subject: [PATCH 7/7] gpio-vbus: ask for vbus_draw regulator before
	registering xceiv
In-Reply-To: <BANLkTimhus3KjV=RXbpLmn6hy2xY9ZZM+Q@mail.gmail.com>
References: <1301666188-11822-1-git-send-email-dbaryshkov@gmail.com>
	<1301666188-11822-7-git-send-email-dbaryshkov@gmail.com>
	<BANLkTimhus3KjV=RXbpLmn6hy2xY9ZZM+Q@mail.gmail.com>
Message-ID: <20110502233852.GA10108@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2011 at 04:42:28PM +0800, Eric Miao wrote:
> On Fri, Apr 1, 2011 at 9:56 PM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
> > Ask for vbus_draw regulator before registering tranceiver to disallow possible
> > race between registration and set_power/etc.
> >
> > Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> 
> Acked-by: Eric Miao <eric.y.miao@gmail.com>
> 
> Greg, can you help take this patch. This looks like a good fix.

I could if I could get it in a format I could apply it in :(

Can someone resend it?

thanks,

greg k-h

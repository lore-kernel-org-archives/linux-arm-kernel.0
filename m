From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 15 Oct 2009 20:51:17 +0400
Subject: [RFC] Re-order of PXA-based platforms in Kconfig and Makefile
In-Reply-To: <f17812d70910100901m57999415mecc637a05921e78a@mail.gmail.com>
References: <f17812d70910100901m57999415mecc637a05921e78a@mail.gmail.com>
Message-ID: <20091015165117.GA23632@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 11, 2009 at 12:01:19AM +0800, Eric Miao wrote:
> All,
> 
> I've listed almost all the PXA based platforms currently existing in mainline
> kernel as below. Due to the naming mess in Kconfig and Makefile, I'd like to
> get them sorted in the following order:
> 
>   1. By category:
>      Intel/Marvell Dev Platforms, followed by 3rd party platforms, followed
>      by end-user products (this is to ensure the commonly referenced platforms
>      will appear first)
> 
>   2. By vendor name in alphabetic within each category
>      (this is to ensure code reuse and similar platforms can be grouped as
>       much as possible)
> 
> Patch is attached, and any problems, please let me know.
> 
> - eric
> 
> Vendor		Board Name	Processor	Maintaneance Status
[...]
> HP		HX4700		PXA27x		Philipp Zabel <philipp.zabel@gmail.com>
> HP		H5000		PXA27x		Unknown (initial submission by:
> 							Anton Vorontsov <cbouatmailru@gmail.com>
> 							Milan Plzik <milan.plzik@gmail.com>)

I still have the H5000 (as well as HX4700) machine, and I'm still
interested in it. The active development/mainlining suspended a
bit, but I hope to get to it soon (heh).

The latest version of the patch looks good, thanks!

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2

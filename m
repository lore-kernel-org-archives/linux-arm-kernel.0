From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 24 Nov 2010 12:33:14 +0200
Subject: [PATCH v2 2/4] drivers: hwspinlock: add OMAP implementation
In-Reply-To: <1290554607.3647.12.camel@atlantis.mindbit.ro>
References: <1290526740-27624-1-git-send-email-ohad@wizery.com>
	<1290526740-27624-3-git-send-email-ohad@wizery.com>
	<1290554607.3647.12.camel@atlantis.mindbit.ro>
Message-ID: <AANLkTinqZ7sMK3kOVV-7UBwx2q9qPoVr3zbze9Qp+0cm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 24, 2010 at 1:23 AM, Ionut Nicu <ionut.nicu@mindbit.ro> wrote:
> At iounmap_base you unmap state->io_base, but that's set only after this
> check. You should probably iounmap(io_base).

Of course. Thanks.


>
> Regards,
> Ionut.
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>

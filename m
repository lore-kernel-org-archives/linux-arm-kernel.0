From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 2 Jan 2018 14:55:08 +0100 (CET)
Subject: [Cluster-devel] [PATCH 00/12] drop unneeded newline
In-Reply-To: <1878806802.2632123.1514901158666.JavaMail.zimbra@redhat.com>
References: <1514386305-7402-1-git-send-email-Julia.Lawall@lip6.fr>
 <1878806802.2632123.1514901158666.JavaMail.zimbra@redhat.com>
Message-ID: <alpine.DEB.2.20.1801021454090.24055@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 2 Jan 2018, Bob Peterson wrote:

> ----- Original Message -----
> | Drop newline at the end of a message string when the printing function adds
> | a newline.
>
> Hi Julia,
>
> NACK.
>
> As much as it's a pain when searching the source code for output strings,
> this patch set goes against the accepted Linux coding style document. See:
>
> https://www.kernel.org/doc/html/v4.10/process/coding-style.html#breaking-long-lines-and-strings

I don't think that's the case:

"However, never break user-visible strings such as printk messages,
because that breaks the ability to grep for them."

julia

>
> Regards,
>
> Bob Peterson
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

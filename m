From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 14 Sep 2010 14:15:14 +0800
Subject: [PATCH 6/9] Remove unused pxa3xx default configuration
In-Reply-To: <1284390832-7181-7-git-send-email-vince@kyllikki.org>
References: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
	<1284390832-7181-7-git-send-email-vince@kyllikki.org>
Message-ID: <AANLkTin4=P06Kcscdo6mwtBPt-DFSD=+Gykkh-sT6RE=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 13, 2010 at 11:13 PM, Vincent Sanders <vince@kyllikki.org> wrote:
> From: Vincent Sanders <vince@simtec.co.uk>
>
> The pxa3xx default configuration has not built throughout the 2.6.36
> series (since 2.6.35-git1). The kernel link has failed with
>
> fs/built-in.o: In function `nfs_callback_authenticate':
> compr_lzo.c:(.text+0x817bc): undefined reference to `svc_gss_principal'
>
> This configuration appers to be unused by the maintainer so remove it.
>
> Signed-off-by: Vincent Sanders <vince@kyllikki.org>
> ---

Hi Vincent,

Thanks for your reporting on this build failure. Please hold on this
patch. I can fix it.

Best Regards
Haojian

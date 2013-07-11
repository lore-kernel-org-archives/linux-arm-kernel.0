From: kyungsik.lee@lge.com (Kyungsik Lee)
Date: Thu, 11 Jul 2013 13:34:33 +0900
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130710182815.GA362@x4>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <1367829775-4434-2-git-send-email-kyungsik.lee@lge.com>
 <20130506095124.GA22041@pd.tnic>
 <CAMuHMdWH9w5fj6HRXi+9QcBJym4dukAFsPVGZVqSSk3yTZJUcA@mail.gmail.com>
 <20130710093642.GC14873@pd.tnic> <20130710182815.GA362@x4>
Message-ID: <20130711043433.GA29245@hulk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> BTW speaking of introductory-level patches, what about the following
> one:
> 
> Now that lz4 kernel compression is available, add *.lz4 to .gitignore
> 
> diff --git a/.gitignore b/.gitignore
> index 3b8b9b3..7e9932e 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -29,6 +29,7 @@ modules.builtin
>  *.bz2
>  *.lzma
>  *.xz
> +*.lz4
>  *.lzo
>  *.patch
>  *.gcno
> 
Acked-by: Kyungsik Lee <kyungsik.lee@lge.com>

Thanks,
Kyungsik

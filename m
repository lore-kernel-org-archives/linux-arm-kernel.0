From: corbet@lwn.net (Jonathan Corbet)
Date: Sat, 14 May 2016 10:15:31 -0600
Subject: [PATCH -trivial 1/3] Documentation: vm: Spelling
 s/paltform/platform/g
In-Reply-To: <1462906798-27993-1-git-send-email-geert+renesas@glider.be>
References: <1462906798-27993-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20160514101531.1b13c542@lwn.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 May 2016 20:59:56 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> diff --git a/Documentation/vm/hugetlbpage.txt b/Documentation/vm/hugetlbpage.txt
> index 54dd9b9c6c31aeed..6f3b3fa35613d900 100644
> --- a/Documentation/vm/hugetlbpage.txt
> +++ b/Documentation/vm/hugetlbpage.txt
> @@ -275,10 +275,10 @@ This command mounts a (pseudo) filesystem of type hugetlbfs on the directory
>  options sets the owner and group of the root of the file system.  By default
>  the uid and gid of the current process are taken.  The mode option sets the
>  mode of root of file system to value & 01777.  This value is given in octal.
> -By default the value 0755 is picked. If the paltform supports multiple huge
> +By default the value 0755 is picked. If the platform supports multiple huge

Applied to the docs tree, thanks.

jon

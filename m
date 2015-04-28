From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Tue, 28 Apr 2015 15:40:45 -0500
Subject: [PATCH] arm: vdso: .gitignore: ignore generated vdso.so.raw and
 vdsomunge
In-Reply-To: <1430253120-27568-1-git-send-email-andrej.skvortzov@gmail.com>
References: <1430253120-27568-1-git-send-email-andrej.skvortzov@gmail.com>
Message-ID: <553FF04D.6010402@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2015 03:32 PM, Andrey Skvortsov wrote:
> After kernel is built 'git status' reports:
> 
>  # Untracked files:
>  #   (use "git add <file>..." to include in what will be committed)
>  #
>  #        arch/arm/vdso/vdso.so.raw
>  #        arch/arm/vdso/vdsomunge
> 
> These files are created during build process and removed with 'make
> clean'. This patch makes git to ignore them.

Thanks, but this should be fixed already by:

2b507a2d9c7f ARM: 8343/1: VDSO: add build artifacts to .gitignore

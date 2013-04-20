From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 21 Apr 2013 00:43:24 +0400
Subject: [PATCH 0/5] OKI ML86V7667 driver and R8A7778/BOCK-W VIN support
In-Reply-To: <201304210013.46110.sergei.shtylyov@cogentembedded.com>
References: <201304210013.46110.sergei.shtylyov@cogentembedded.com>
Message-ID: <5172FDEC.3070200@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 04/21/2013 12:13 AM, Sergei Shtylyov wrote:

>     Here's the set of 4 patches against the Simon Horman's 'renesas.git' repo,
> 'renesas-next-20130419' tag and my recent yet unapplied patches. Here we
> add the OKI ML86V7667 video decoder driver and the VIN platform code working on
> the R8A7778/BOCK-W with ML86V7667. The driver patch also applies (with offsets)
> to Mauro's 'media_tree.git'...
>
> [1/5] V4L2: I2C: ML86V7667 video decoder driver
> [2/5] sh-pfc: r8a7778: add VIN pin groups
> [3/5] ARM: shmobile: r8a7778: add VIN support
> [4/5] ARM: shmobile: BOCK-W: add VIN and ADV7180 support
> [5/5] ARM: shmobile: BOCK-W: enable VIN and ADV7180 in defconfig

     s/ADV7180/ML86V7667/. Sorry, used the old cover letter as a template
and forgot to fix the decoder name.

WBR, Sergei

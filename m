From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jul 2016 13:58:15 +0200
Subject: [GIT PULL] STi defconfig updates for v4.8
In-Reply-To: <57767948.6090009@st.com>
References: <57767948.6090009@st.com>
Message-ID: <3903716.QdcLzaNlmI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 1, 2016 4:08:08 PM CEST Patrice Chotard wrote:
> Patrice Chotard (2):
>        ARM: multi_v7_defconfig: enable STMicroelectronics BDISP 2D 
> blitter driver
>        ARM: multi_v7_defconfig: enable STMicroelectronics DRM Support
> 

Please rebase this on top of v4.7-rc3 and add a signed tag with
a branch description for the changelog.

Generally, we try to avoid backmerging later -rc releases into our
branches as that messes up the git history, so you should base
either on -rc1 or check what the latest -rc is in our next/* branches.

The tag description is what ends up in the merge commit.

	Arnd

From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 20:32:14 -0700
Subject: [GIT PULL] Gemini DTS additions
In-Reply-To: <CACRpkdYtj2JtBXZeHNJjf8QS1_FWvKbVUMXZJ9jvtQ3zEWVX+g@mail.gmail.com>
References: <CACRpkdYtj2JtBXZeHNJjf8QS1_FWvKbVUMXZJ9jvtQ3zEWVX+g@mail.gmail.com>
Message-ID: <20170619033214.GL30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 12:05:08AM +0200, Linus Walleij wrote:
> The Gemini DMA controller and PATA/SATA drivers
> have been merged by respective subsystem maintainers.
> 
> This adds the DMA and PATA/SATA DTS entries with
> numerical values for clocks and resets, which will be
> augmented to #defines after -rc1.
> 
> The tag is based on top of the previous Gemini DTS
> tag for v4.13, so goes into the same branch I guess.
> 
> Please pull it in!
> 
> Yours,
> Linus Walleij
> 
> 
> The following changes since commit 664ed4e283926d753e876a1347b7729135a3f6b8:
> 
>   ARM: dts: Add clocks to the Gemini SoC (2017-05-24 10:50:22 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
> tags/gemini-v4.13-dts-2
> 
> for you to fetch changes up to 0d7a2c35d11e974b98a6396cd24b39b0f3f5bb7b:
> 
>   ARM: dts: add Gemini PATA/SATA support (2017-06-13 23:58:00 +0200)

Merged, thanks!


-Olof

From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 27 Mar 2015 12:00:33 +0000
Subject: [PATCH 0/2] tc3589x OF only enforcement
In-Reply-To: <CACRpkdZC-+fZXRAqnir2+pyq-es=-zA9jS2qGUiOF75KqzSLqQ@mail.gmail.com>
References: <1426776765-18812-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZC-+fZXRAqnir2+pyq-es=-zA9jS2qGUiOF75KqzSLqQ@mail.gmail.com>
Message-ID: <20150327120033.GF15988@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Mar 2015, Linus Walleij wrote:

> On Thu, Mar 19, 2015 at 3:52 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > These two patches removes the non-DT probe/config path from the
> > TC3589x driver. I suggest merging both through the MFD tree if
> > Dmitry can ACK the input patch.
> 
> Lee it seems Dmitry ACKed these patches, can you merge those
> two patches into MFD? I don't think there will be any cross-tree deps
> so you can just carry them  in MFD without any immutable branch business.

Change of plan.  20f02d6 scuppers you plans unfortunately.  Probably
best if this goes in via the Input tree.

Both patches unapplied.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

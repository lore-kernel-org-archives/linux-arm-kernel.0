From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Fri, 31 Oct 2014 13:12:21 -0700
Subject: [PATCH 2/3] ARM: Remove redundant ARCH_SPARSEMEM_DEFAULT setting
In-Reply-To: <1410488562-21863-2-git-send-email-cernekee@gmail.com>
References: <1410488562-21863-1-git-send-email-cernekee@gmail.com>
 <1410488562-21863-2-git-send-email-cernekee@gmail.com>
Message-ID: <CADtm3G4etUzQ6hQWz61UAdu9Q8SUQPNKnVz3tunhQvC-u62YaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 7:22 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
> If ARCH_SPARSEMEM_ENABLE=y and ARCH_{FLATMEM,DISCONTIGMEM}_ENABLE=n,
> then the logic in mm/Kconfig already makes CONFIG_SPARSEMEM the only
> choice.  This is true for all of the existing ARM users of
> ARCH_SPARSEMEM_ENABLE.
>
> Forcing ARCH_SPARSEMEM_DEFAULT=y if ARCH_SPARSEMEM_ENABLE=y prevents
> us from ever defaulting to FLATMEM, so we should remove this setting.
>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>

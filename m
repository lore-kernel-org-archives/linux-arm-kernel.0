From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Fri, 31 Oct 2014 13:12:46 -0700
Subject: [PATCH 3/3] ARM: Allow either FLATMEM or SPARSEMEM on the
 multi-v7 build
In-Reply-To: <1410488562-21863-3-git-send-email-cernekee@gmail.com>
References: <1410488562-21863-1-git-send-email-cernekee@gmail.com>
 <1410488562-21863-3-git-send-email-cernekee@gmail.com>
Message-ID: <CADtm3G5sUHY8+DLoUEFPtCqj7JBujGbM3FGEWQHje53TV2x5vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 7:22 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
> ARMv7 chips with LPAE can often benefit from SPARSEMEM, as portions of
> system memory can be located deep in the 36-bit address space.  Allow
> FLATMEM or SPARSEMEM to be selectable at compile time; FLATMEM remains
> the default.
>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>

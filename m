From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Wed, 3 Oct 2018 15:31:12 +0200
Subject: [PATCH v7 0/8] arm64: untag user pointers passed to the kernel
In-Reply-To: <cover.1538485901.git.andreyknvl@google.com>
References: <cover.1538485901.git.andreyknvl@google.com>
Message-ID: <20181003133110.4y3xhexjrvffivff@ltop.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 02, 2018 at 03:12:35PM +0200, Andrey Konovalov wrote:
...

> Changes in v7:
> - Rebased onto 17b57b18 (4.19-rc6).
> - Dropped the "arm64: untag user address in __do_user_fault" patch, since
>   the existing patches already handle user faults properly.
> - Dropped the "usb, arm64: untag user addresses in devio" patch, since the
>   passed pointer must come from a vma and therefore be untagged.
> - Dropped the "arm64: annotate user pointers casts detected by sparse"
>   patch (see the discussion to the replies of the v6 of this patchset).
> - Added more context to the cover letter.
> - Updated Documentation/arm64/tagged-pointers.txt.

Hi,

I'm quite hapy now with what concerns me (sparse).
Please, feel free to add my:
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>


Cheers,
-- Luc Van Oostenryck

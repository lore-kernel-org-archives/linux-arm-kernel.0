From: dianders@chromium.org (Doug Anderson)
Date: Fri, 29 Jan 2016 14:14:50 -0800
Subject: [PATCH v6 0/5] dma-mapping: Patches for speeding up allocation
In-Reply-To: <CAD=FV=XEML4UqV-oVR4doZNSq6bNxDvpc-4745JTBZgf4d9UYA@mail.gmail.com>
References: <1452533428-12762-1-git-send-email-dianders@chromium.org>
 <20160126155937.6a4e4165d1cf4e513d62e942@linux-foundation.org>
 <CAD=FV=V9ZJrmD=F8363mhg8+JQiTRg=g6DuZR2KJRbfU=K455w@mail.gmail.com>
 <CAOesGMg=7mzZ6wKgjB1Po3706FGYu+D06YWWBBTya6KOE7531g@mail.gmail.com>
 <CAD=FV=XEML4UqV-oVR4doZNSq6bNxDvpc-4745JTBZgf4d9UYA@mail.gmail.com>
Message-ID: <CAD=FV=XwnQ2dPi0YsD12vpqQxPDAJ9RNhWfHkJhszEhxiSrU7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 29, 2016 at 1:58 PM, Doug Anderson <dianders@chromium.org> wrote:
>> I think it makes sense to send these through Russell's tracker for him
>> to merge, especially since I don't think there are any dependencies on
>> them for SoC-specific patches coming up.
>
> Sounds good.  I'll make the nitfixes and I'll post a v7 directly to
> Russell's tracker.  I'll follow up here with a link to those patches.

For your viewing pleasure:

8505/1 dma-mapping: Optimize allocation
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8505/1

8506/1 common: DMA-mapping: add DMA_ATTR_ALLOC_SINGLE_PAGES attribute
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8506/1

8507/1 dma-mapping: Use DMA_ATTR_ALLOC_SINGLE_PAGES hint to optimize alloc
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8507/1

8508/1 videobuf2-dc: Let drivers specify DMA attrs
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8508/1

8509/1 s5p-mfc: Set DMA_ATTR_ALLOC_SINGLE_PAGES
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8509/1

---

Changes in v7 (AKA the above patches):
- Add Robin and Tomasz Reviewed-by.
- Add Javier Tested-by.
- Add note that this is only implemented on ARM (Andrew Morton).
- Typo in commit message "reqiurements" (Andrew Morton).


-Doug

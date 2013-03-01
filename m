From: olof@lixom.net (Olof Johansson)
Date: Thu, 28 Feb 2013 22:19:58 -0800
Subject: [GIT PULL 0/3] arm-soc: late changes for 3.9
In-Reply-To: <CA+55aFx2Cuuq2YW6mexxZ88TNm=FLYUYPzeLqN=y46oYxZJ3wQ@mail.gmail.com>
References: <1362092093-4839-1-git-send-email-olof@lixom.net>
 <CA+55aFx2Cuuq2YW6mexxZ88TNm=FLYUYPzeLqN=y46oYxZJ3wQ@mail.gmail.com>
Message-ID: <CAOesGMiMWaEmPMJ2q2t9gsTa2gFZm_iwc6v9wO7htyPrOKNx=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 28, 2013 at 8:18 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

>> I've pushed a resolved branch for reference (late-branches-resolved)
>> in case you want to compare conflict resolutions.
>
> So Arnd's tag talked about removing the stale gpio.h, but I think it
> was the i2c.h that was now also stale. So I removed both - even though
> technically, the merge should have left i2c.h since it was in both
> parents. You should double-check that, but I don't see how that
> <linux/i2c.h> could *possibly* be valid any more, and people had tried
> (unsuccessfully) to remove it once already, so...

The i2c include is definitely unnecessary since there's no
i2c_board_info stuff left in the file. Thanks for catching that.


-Olof

From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 12 Jun 2011 22:31:44 -0600
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <BANLkTik_hH9tZ5MMbOYzhZwLFTFQyJyfRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2011 at 12:06 AM, Nicolas Pitre
<nicolas.pitre@linaro.org> wrote:
> This is a resend of those patches with fixups after the latest changes
> in mainline.
>
> [PATCH 1/3] ARM: zImage: ensure it is always a multiple of 64 bits in size
> This one is new and trivial.
>
> [PATCH 2/3] ARM: zImage: Allow the appending of a device tree binary
> Mostly John Bonesio's version with some adjustments and cleanups.
>
> [PATCH 3/3] ARM: zImage: make sure appended DTB doesn't get overwritten by kernel .bss
> New, simpler alternative to Tony Lindgren's version.

I've gone ahead and added the series to devicetree/test for anyone who
want to play with it.

Thanks,
g.


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

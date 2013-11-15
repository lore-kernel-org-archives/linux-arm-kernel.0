From: tim.kryger@linaro.org (Tim Kryger)
Date: Fri, 15 Nov 2013 15:30:06 -0800
Subject: [PATCH v2 0/5] Add-Broadcom-Kona-I2C-Support
In-Reply-To: <20131115225234.GC2672@katana>
References: <1384462936-7906-1-git-send-email-tim.kryger@linaro.org>
 <20131115225234.GC2672@katana>
Message-ID: <CAAYSxhrk6qgfy3TUdme3ge98d8Db7e=aW3LG8VfsJgjfuHAS3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 15, 2013 at 2:52 PM, Wolfram Sang <wsa@the-dreams.de> wrote:

> Fixed Kconfig sorting, squashed broken out patches 1-3 into one and
> applied to for-next, thanks! Let me know if I should take patches 4-5
> also, but usually they go via arm-soc. Also, please provide a "Changes
> since V1" log which will speed up reviewing.

Thanks.  It appears that when I updated the dependencies, I
accidentally removed the change list I had planned to send.  This is
what should have appeared in my cover letter:

Changes in v2:
  - Binding documentation is in its own patch
  - Minor cosmetic changes
  - Fixed bug related to improper signedness
  - Removed superflous mutex
  - Simplified probe function

I think it would be best for the DTS changes (patches 4 and 5) to go
through Christian's tree.

-Tim

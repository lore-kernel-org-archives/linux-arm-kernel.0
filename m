From: pefoley2@pefoley.com (Peter Foley)
Date: Tue, 9 Sep 2014 12:21:56 -0400
Subject: [PATCH 1/3] kbuild: remove unnecessary "obj- := dummy.o" trick
In-Reply-To: <1410258381-7088-2-git-send-email-yamada.m@jp.panasonic.com>
References: <1410258381-7088-1-git-send-email-yamada.m@jp.panasonic.com>
 <1410258381-7088-2-git-send-email-yamada.m@jp.panasonic.com>
Message-ID: <CAOFdcFMs7j3CAnu4XSFCSaYwKub5KcTqyz97C=0U9KbcRZEGOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 9, 2014 at 6:26 AM, Masahiro Yamada
<yamada.m@jp.panasonic.com> wrote:
> In these Makefiles, at least one of "obj-y" and "obj-" is non-empty,
> hence built-in.o is always created without such a trick.
>
> Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>

Acked-by: Peter Foley <pefoley2@pefoley.com>

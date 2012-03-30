From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 30 Mar 2012 11:14:15 +0100
Subject: [PATCH v6 1/5] Extcon (external connector): import Android's
 switch class and modify.
In-Reply-To: <CAJ0PZbT728rhQ5esf0arRw-TtgBGMCgAvZhW9-AejmbT9WOahw@mail.gmail.com>
References: <1328856038-21912-1-git-send-email-myungjoo.ham@samsung.com>
 <1330344939-18394-1-git-send-email-myungjoo.ham@samsung.com>
 <1330344939-18394-2-git-send-email-myungjoo.ham@samsung.com>
 <20120309124119.GV3273@opensource.wolfsonmicro.com>
 <CACSP8ShU5tu=9N53PtYMLyFVFMS9whNRhMvu7nu8rBoPuVCy+Q@mail.gmail.com>
 <CAJ0PZbT728rhQ5esf0arRw-TtgBGMCgAvZhW9-AejmbT9WOahw@mail.gmail.com>
Message-ID: <20120330101414.GC21950@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 05:56:01PM +0900, MyungJoo Ham wrote:

> With class_compat as in patchset v7, (this thread is w/ v6) does the
> issue (missing link from device name directory) still exist? (I don't
> think so)

Not unless the uevents are issued with both names.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120330/b352b40b/attachment-0001.sig>

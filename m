From: xiechao.mail@gmail.com (Chao Xie)
Date: Thu, 21 Mar 2013 17:16:15 +0800
Subject: [PATCH 2/6] usb: otg: mv_otg: remove unused clock
In-Reply-To: <20130320130927.GT29659@arwen.pp.htv.fi>
References: <1363593333-6077-1-git-send-email-chao.xie@marvell.com>
 <1363593333-6077-3-git-send-email-chao.xie@marvell.com>
 <20130320130927.GT29659@arwen.pp.htv.fi>
Message-ID: <CADApbehYSCqrUkiMic3Qga4L3shFGOyHUr=THO=zadLb7ecr+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 9:09 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Mon, Mar 18, 2013 at 03:55:29AM -0400, Chao Xie wrote:
>> The origianl understanding of clock is wrong. The OTG controller
>> only have one clock input.
>> Passing clock name by pdata is wrong. The clock is defined by device
>> iteself.
>>
>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>
> please rebase against my 'next' branch.
>
> --
> balbi
hi
Do you mean git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git -
branch "usb-next"?
Or some other git?

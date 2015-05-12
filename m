From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 12 May 2015 23:40:12 +0300
Subject: [PATCH v2 04/17] input: locomokbd: provide an Alt-SysRQ
 combination
In-Reply-To: <20150512201215.GD20725@dtor-ws>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-5-git-send-email-dbaryshkov@gmail.com>
 <20150512201215.GD20725@dtor-ws>
Message-ID: <CALT56yO+fiPfm6hhx+E3dAyrE1G8SSdcX3VpXXqW4=UuTh-4qA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-12 23:12 GMT+03:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> Hi Dmitry,
>
> On Tue, Apr 28, 2015 at 02:55:41AM +0300, Dmitry Eremin-Solenikov wrote:
>> It is usefull sometimes to have an Alt-SysRQ combo on the keyboard to be
>> able to trigger sysrq functions directly. Add an option providing sysrq
>> mapping for Contact-Home keys.
>
> No, if you want to remap the keys please do it from usepspace; locomokbd
> supports it (EVIOCSKEYCODE ioctl).

OK, this was useful to boot kernels with minimal to no userspace (tiny
initramfs)
and still have the SysRQ at hand. I'll keep this as a local/OE patch instead.

-- 
With best wishes
Dmitry

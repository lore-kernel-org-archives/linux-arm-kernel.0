From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 19 May 2015 13:55:29 +0200
Subject: [PATCH v4 3/7] mmc: mediatek: Add PM support for MMC driver
In-Reply-To: <20150519110453.GD26575@pengutronix.de>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
 <1432017411-2996-4-git-send-email-chaotian.jing@mediatek.com>
 <20150519110453.GD26575@pengutronix.de>
Message-ID: <CAPDyKFo=f-8aycE9wPjdWEjdVLLz8Lk=Pt2=JeTL3CSM-2Gj4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 May 2015 at 13:04, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> Hi Chaotian,
>
> On Tue, May 19, 2015 at 02:36:47PM +0800, Chaotian Jing wrote:
>> Add PM support for Mediatek MMC driver
>> Save/restore registers when PM
>
> Has anyone asked you to add a new driver in two steps? I find it hard to
> review if a driver is introduced and changed right afterwards.
> Presumably you find it hard to maintain the patches like this also.
> Please ignore if this is indeed requested by someone.

I requested it.

Primarily because I want to make sure we deal with runtime/system PM
support properly. I guess I have seen too many cases where
functionality is broken, unless compiled with CONFIG_PM* set.

Kind regards
Uffe

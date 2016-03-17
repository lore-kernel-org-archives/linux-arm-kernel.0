From: airlied@gmail.com (Dave Airlie)
Date: Thu, 17 Mar 2016 12:43:11 +1000
Subject: [PATCH 0/8] drm: atmel-hlcdc: various fixes/improvements
In-Reply-To: <20160301115551.52f0887b@bbrezillon>
References: <1452075569-8545-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160301115551.52f0887b@bbrezillon>
Message-ID: <CAPM=9tz0rZMwy6JTqzjcSQC+DAPYkjBOiU746C0smyMA0OCGzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 March 2016 at 20:55, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> On Wed,  6 Jan 2016 11:19:21 +0100
> Boris Brezillon <boris.brezillon@free-electrons.com> wrote:
>
>> Hello,
>>
>> This series is a collection of fixes and improvements for the
>> atmel-hlcdc driver.
>>
>> The main feature added here is the support for external RGB -> XXX
>> bridges (patch 6 and 7).
>>
>> The first patch is a fix preventing a potential memory leak.
>> Patch 2 is adding support for asynchronous mode setting, which was
>> supported before the migration to atomic mode setting.
>>
>> Patch 3 is just a minor fix to expose the real encoder and connector
>> types (we are currently exposing an LVDS encoder/connector, which is
>> wrong since the display controller output the pixel stream in raw
>> RGB).
>>
>> Patch 4 is removing useless fields and functions which were left
>> when moving to atomic modesetting.
>>
>> And patch 8 is just a cosmetic patch moving the mode checking code
>> from ->atomic_check() to ->mode_fixup().
>
> Dave, Daniel, any comment on this series (AKA ping)?

On internal driver stuff, I'd usually only look on a git pull :-)

Dave.

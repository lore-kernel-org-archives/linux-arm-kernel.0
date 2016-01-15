From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Fri, 15 Jan 2016 13:06:52 +0200
Subject: [PATCH] drm: nouveau: fix nouveau_debugfs_init prototype
In-Reply-To: <12563536.Vhe8JJPi2x@wuerfel>
References: <3968390.Pvmnq3v7oC@wuerfel>
 <1503925101.39877.1452693347204.JavaMail.open-xchange@www.ud-mail.de>
 <12563536.Vhe8JJPi2x@wuerfel>
Message-ID: <CACvgo50aGCMBB3Qe3o5jyV7oZ62yiDRHcLAy4xu-Nnmb5S_DaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 January 2016 at 16:00, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 13 January 2016 14:55:47 Karol Herbst wrote:
>> > Arnd Bergmann <arnd@arndb.de> hat am 13. Januar 2016 um 14:48 geschrieben:
>> >
>> > The new debugfs initialization code fails to build when CONFIG_DEBUG_FS
>> > is disabled:
>> >
>> > In file included from /git/arm-soc/drivers/gpu/drm/nouveau/nouveau_drm.c:57:0:
>> > drivers/gpu/drm/nouveau/nouveau_debugfs.h: In function 'nouveau_debugfs_init':
>> > drivers/gpu/drm/nouveau/nouveau_debugfs.h:37:29: error: parameter name omitted
>> >  nouveau_debugfs_init(struct nouveau_drm *)
>> >
>> > This fixes the prototypes so we can build it again.
>> >
>>
>> thanks for this. I already send a patch to the nouveau ML here:
>> http://lists.freedesktop.org/archives/nouveau/2016-January/023779.html
>
> Ok, thanks
>
Fwiw Arnd's fix feels a lot better - it lacks typos, has a fixes tag,
comprehensive commit message etc. etc. :-)

-Emil

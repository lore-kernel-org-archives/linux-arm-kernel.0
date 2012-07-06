From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 6 Jul 2012 10:37:19 +0800
Subject: [PATCH] clk: wm831x: fix checkpatch issue for static const char *
 array
In-Reply-To: <20120704101936.GD4111@opensource.wolfsonmicro.com>
References: <1341395680-14142-1-git-send-email-Barry.Song@csr.com>
 <20120704101936.GD4111@opensource.wolfsonmicro.com>
Message-ID: <CAGsJ_4zruQM8GhGGat_nCmoRd1R3Q-fSHV_OJs=yW6dnOQvYTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/7/4 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Wed, Jul 04, 2012 at 05:54:40PM +0800, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> static const char * array should probably be static const char * const
>
> We need some additional clock API patches to get merged before this is
> OK, last time I checked the API wasn't const correct enough for it.
>
ok. also with this conflict: "warning: initialization discards
qualifiers from pointer target type"

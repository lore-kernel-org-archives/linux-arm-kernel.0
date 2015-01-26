From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 26 Jan 2015 13:14:29 +0900
Subject: [PATCH 06/13] ARM: shmobile: mackerel: Remove defconfig
In-Reply-To: <CAMuHMdW7WF00LHheNAkQZQizrO0MH91EScuuR1_hwebRqznXrA@mail.gmail.com>
References: <20150121045256.7648.7451.sendpatchset@little-apple>
 <20150121045357.7648.6160.sendpatchset@little-apple>
 <CAMuHMdW7WF00LHheNAkQZQizrO0MH91EScuuR1_hwebRqznXrA@mail.gmail.com>
Message-ID: <CANqRtoTj1jFD8np5U+SOk9DW-=-x5=sss=sTYQE1VYYJvYtXbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Wed, Jan 21, 2015 at 7:46 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Wed, Jan 21, 2015 at 5:53 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Remove the defconfig for the no longer supported mackerel board.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>  arch/arm/configs/mackerel_defconfig |  157 -----------------------------------
>>  1 file changed, 157 deletions(-)
>
> You forgot the reference to mackerel_defconfig in MAINTAINERS.

Oops, thanks for letting me know. Will fix and resend.

Cheers,

/ magnus

From: notasas@gmail.com (Grazvydas Ignotas)
Date: Sun, 17 Feb 2013 00:37:58 +0200
Subject: [PATCH 1/2] ARM: OMAP2+: Prevent potential crash if GPMC probe
 fails
In-Reply-To: <518397C60809E147AF5323E0420B992E3EA754E2@DBDE01.ent.ti.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
 <1359736726-10193-2-git-send-email-jon-hunter@ti.com>
 <20130201220804.GZ22517@atomide.com> <51158293.8010101@ti.com>
 <20130209155547.GA5253@localhost>
 <518397C60809E147AF5323E0420B992E3EA754E2@DBDE01.ent.ti.com>
Message-ID: <CANOLnOO5ZrwonjrROawkLFpAsxgrJOsan-mjeOyOcYOZU6sizQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 2:04 PM, Philip, Avinash <avinashphilip@ti.com> wrote:
> Hi Tony,
>
> On Sat, Feb 09, 2013 at 21:25:49, Ezequiel Garcia wrote:
>> On Fri, Feb 08, 2013 at 04:56:19PM -0600, Jon Hunter wrote:
>> Without this patch, GPMC is currently broken on my igep board setup,
>> if initialized through a device tree.
>>
>> Tested-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>
> Without this patch GPMC is not working in am335x-evm.
>
> Tested-by: Philip Avinash <avinashphilip@ti.com>
>
> See Jon's comments.
>
> JON >> Hi Tony, this one appears to be merged incorrectly. The unreserve ended
> JON >> up in the gpmc_calc_timings() function. Here is a patch to fix.

Just wasted a hour or a few trying to figure out this problem, can we
get this merged now? Maybe Jon can resend this with all the tested-bys
to catch Tony's attention?

Tested-by: Grazvydas Ignotas <notasas@gmail.com>


-- 
Gra?vydas

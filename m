From: drake@endlessm.com (Daniel Drake)
Date: Mon, 14 Jul 2014 16:25:42 +0100
Subject: [alsa-devel] [PATCH V3 2/2] ASoC: samsung: Add machine driver for
 Odroid X2/U3
In-Reply-To: <53BEBC3F.6030205@samsung.com>
References: <1404479625-25385-1-git-send-email-s.nawrocki@samsung.com>
 <1404479625-25385-2-git-send-email-s.nawrocki@samsung.com>
 <CAD8Lp44JFtbcD22c+0PVb5S4U1kVTTxHD=PgqiKzhVypFW5Prg@mail.gmail.com>
 <53BEBC3F.6030205@samsung.com>
Message-ID: <CAD8Lp460Ym1y5OS8ya=jddO-spnojyGVWkUWhXmKCfbOOGL61A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 10, 2014 at 5:15 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> On 08/07/14 11:15, Daniel Drake wrote:
>> Testing on ODROID-U2, v3 is not quite working for me, but v2 of the
>> patch was fine.
>> I boot up, run:
>> # speaker-test -c 2 -t wav
>>
>> As soon as I hear the word "front" I press ctrl+c and then run the
>> command again.
>> Now the command hangs with no audible output.
>>
>> Any ideas? Let me know if you have trouble reproducing.
>
> I just posted a patch addressing this, please let me know
> if there are any further issues.


Sorry for not testing sooner. Your patch solves the issue.

Thanks
Daniel

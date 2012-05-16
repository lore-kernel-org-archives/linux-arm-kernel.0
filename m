From: omar.luna@linaro.org (Omar Ramirez Luna)
Date: Tue, 15 May 2012 21:20:19 -0500
Subject: [PATCH 0/3] OMAP: control: bootaddr and bootmod APIs
In-Reply-To: <1336011113-31502-1-git-send-email-omar.luna@linaro.org>
References: <1336011113-31502-1-git-send-email-omar.luna@linaro.org>
Message-ID: <CALLhW=6g59V7UMWMsaiCnr=UYuXo4CRZfpELosfk7xs5XevJTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 May 2012 21:11, Omar Ramirez Luna <omar.luna@linaro.org> wrote:
> Recently a patch went in for tidspbridge code, to ioremap
> SCM registers and solve a build break[1]. However it has
> been pointed out before that this is a layer violation
> given that control module should handle its own registers, this
> series is an attempt to create APIs for the users of these
> registers.
>
> With some adaptations this patch might also make use of it:
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg66491.html
>
> Patch: staging: tidspbridge: use scm functions to set boot address and mode,
> will be sent separately to staging tree.
>
> Tested on OMAP3 Beagleboard.
>
> [1] http://www.mail-archive.com/devel at linuxdriverproject.org/msg18762.html
>
> Omar Ramirez Luna (3):
> ?OMAP2+: control: new APIs to configure boot address and mode
> ?OMAP: dsp: interface to control module functions
> ?staging: tidspbridge: use scm functions to set boot address and mode

Ping.

It seems that I unconsciously copied the previous concept, recently I
dug this thread to explain the reasoning of these patches:

http://www.mail-archive.com/linux-omap at vger.kernel.org/msg38015.html

These were provided by Paul, one of them acked by Kevin, somehow they
were not included and I forgot about them.

My set also includes OMAP4 check, which I heard recently was tested
with the dsp on pandaboard. If needed I can go back to Paul's version
and re-spin them, with minor changes. Please let me know.

Regards,

Omar

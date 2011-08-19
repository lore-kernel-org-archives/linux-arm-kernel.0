From: banajit.goswami@gmail.com (Banajit Goswami)
Date: Fri, 19 Aug 2011 09:40:29 +0530
Subject: [PATCH] ARM: S3C64XX: Remove un-used code
In-Reply-To: <20110819015955.GA1212@sirena.org.uk>
References: <1313498488-4296-1-git-send-email-banajit.g@samsung.com>
	<20110819015955.GA1212@sirena.org.uk>
Message-ID: <CABK8_vR6bB_0TfQtbA7F9+w9dSXajMdd1SS5o+LscMrDcCY1tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Aug 19, 2011 at 7:29 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Aug 16, 2011 at 06:11:28PM +0530, Banajit Goswami wrote:
>> Remove un-used backlight code for SMDK6410 board
>
> Is the data actually wrong? ?If not it'd seem better to finish hooking
> it up properly than to remove it.
No, this code is no longer needed, as we are having a common backlight
infrastructure , which serves the same purpose.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>

Thanks and Regards,
Banajit Goswami

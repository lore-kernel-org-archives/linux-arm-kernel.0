From: banajit.goswami@gmail.com (Banajit Goswami)
Date: Fri, 19 Aug 2011 12:29:51 +0530
Subject: [PATCH] ARM: S3C64XX: Remove un-used code
In-Reply-To: <20110819045346.GA26979@opensource.wolfsonmicro.com>
References: <1313498488-4296-1-git-send-email-banajit.g@samsung.com>
	<20110819015955.GA1212@sirena.org.uk>
	<CABK8_vR6bB_0TfQtbA7F9+w9dSXajMdd1SS5o+LscMrDcCY1tg@mail.gmail.com>
	<20110819045346.GA26979@opensource.wolfsonmicro.com>
Message-ID: <CABK8_vTSrcAc8Un-z_uDZkJWKeiVP9tPR2YPgkuQybG5gvqMgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, Aug 19, 2011 at 10:23 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Aug 19, 2011 at 09:40:29AM +0530, Banajit Goswami wrote:
>> On Fri, Aug 19, 2011 at 7:29 AM, Mark Brown
>> <broonie@opensource.wolfsonmicro.com> wrote:
>> > On Tue, Aug 16, 2011 at 06:11:28PM +0530, Banajit Goswami wrote:
>> >> Remove un-used backlight code for SMDK6410 board
>
>> > Is the data actually wrong? ?If not it'd seem better to finish hooking
>> > it up properly than to remove it.
>
>> No, this code is no longer needed, as we are having a common backlight
>> infrastructure , which serves the same purpose.
>
> Ideally your commit log should make this clear - it looks like you're
> just deleting unreferenced code.
Thanks.
Will add more description now on.

Thanks and Regards,
Banajit Goswami

From: zonque@gmail.com (Daniel Mack)
Date: Wed, 25 May 2011 13:11:31 +0200
Subject: [PATCH 1/2] ARM: pxa: raumfeld: follow upcoming hardware change
In-Reply-To: <20110524175002.GB4652@n2100.arm.linux.org.uk>
References: <1306239223-8293-1-git-send-email-zonque@gmail.com>
	<20110524175002.GB4652@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikwkr8etp_fBnsUxiSq28VUyTbONQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2011 at 7:50 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, May 24, 2011 at 02:13:42PM +0200, Daniel Mack wrote:
>> The backlight control is going to change back to PWM in the
>> upcoming Raumfeld Controller hardware revision.
>
> The commit comments doesn't say why the LCD timings have changed:

Oh, yes. Seem something went wrong in the rebase process. I'll fix
this and resubmit.

Thanks,
Daniel

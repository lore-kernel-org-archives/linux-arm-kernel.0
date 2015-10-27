From: peter@korsgaard.com (Peter Korsgaard)
Date: Tue, 27 Oct 2015 20:24:22 +0100
Subject: [linux-sunxi] Re: [PATCH 0/6] ARM: sunxi: Introduce Allwinner H3
 support
In-Reply-To: <5628A302.1080908@redhat.com> (Hans de Goede's message of "Thu,
 22 Oct 2015 10:49:06 +0200")
References: <1445444007-4260-1-git-send-email-jenskuske@gmail.com>
 <5627E515.6050505@redhat.com> <562894FE.3040702@gmail.com>
 <5628A302.1080908@redhat.com>
Message-ID: <87d1w09kt5.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Hans" == Hans de Goede <hdegoede@redhat.com> writes:

Hi,

 > 2) I see no pmic code in there. I know these boards do not use an axp pmic,
 > but according to my info at least the Orange Pi 2 (which I have) uses a
 > sy8106a pmic, it is not entirely clear to me yet if this one needs any
 > init though, I've mailed the Orange Pi people about this.

Did you hear back from them? I haven't been able to find any datasheet
describing the i2c interface, but the orange pi pc schematics has a note
that Vout is defined by the Ru1 / Ru2 resistors, so it sounds like i2c
configuration isn't critical to get something running.

-- 
Bye, Peter Korsgaard

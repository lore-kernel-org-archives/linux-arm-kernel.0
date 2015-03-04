From: rjui@broadcom.com (Ray Jui)
Date: Wed, 4 Mar 2015 09:31:15 -0800
Subject: [PATCH v4 1/4] pinctrl: bcm: consolidate Broadcom pinctrl drivers
In-Reply-To: <CACRpkdaiM+mqGg43BT1Kr-CNi8+_U4KgZM4iZocv9+ovHL5hLQ@mail.gmail.com>
References: <rjui@broadcom.com>	<1423015801-26967-1-git-send-email-rjui@broadcom.com>	<1423015801-26967-2-git-send-email-rjui@broadcom.com>
 <CACRpkdaiM+mqGg43BT1Kr-CNi8+_U4KgZM4iZocv9+ovHL5hLQ@mail.gmail.com>
Message-ID: <54F74163.8060801@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On 3/4/2015 1:07 AM, Linus Walleij wrote:
> On Wed, Feb 4, 2015 at 3:09 AM, Ray Jui <rjui@broadcom.com> wrote:
> 
>> Consolidate Broadcom pinctrl drivers into drivers/pinctrl/bcm/*
>>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
> 
> This patch doesn't apply so it needs to be rebased on v4.0-rc1 and resent.
> 
> And also when just moving files, always do this:
> 
> git format-patch -M ...
> 
> So that file movement is detected, and the patch will apply nicely even
> if the contents of the file(s) have changed.
> 
> Can you also combine this series with the v9 GPIO etc series and
> send out ONE big patch set that I can look at because right now I'm
> getting really confused ...
> 
> I'll look over the rest and see if there is some remaining technical
> comments (hopefully mainly patch mechanics remains).
> 
> Yours,
> Linus Walleij
> 

Okay. I'll rebase to v4.0-rc1 and consolidate both pinmux and gpio
pinctrl patch series into one, which will be PATCH v5.

Thanks,

Ray

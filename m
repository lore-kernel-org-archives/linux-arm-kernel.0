From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 24 Mar 2016 11:27:27 +0100
Subject: [PATCH 3/4] arm64: dts: marvell: Clean up armada-7040-db
In-Reply-To: <20160324091832.0060c907@free-electrons.com> (Thomas Petazzoni's
 message of "Thu, 24 Mar 2016 09:18:32 +0100")
References: <1458771861-12392-1-git-send-email-afaerber@suse.de>
 <1458771861-12392-4-git-send-email-afaerber@suse.de>
 <20160324091832.0060c907@free-electrons.com>
Message-ID: <87oaa4npbk.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On jeu., mars 24 2016, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Hello,
>
> On Wed, 23 Mar 2016 23:24:20 +0100, Andreas F?rber wrote:
>> Instead of duplicating the node hierarchy, reference the nodes by label,
>> adding labels where necessary.
>> 
>> Drop some trailing or inconsistent white lines while at it.
>> 
>> Fixes: ec7e5a569bce ("arm64: dts: marvell: add Device Tree files for Armada 7K/8K")
>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>
> We haven't used this solution on Marvell Armada 32-bits SoCs, so there
> needs to be a discussion on whether we want to go in this direction for
> the 64 bits SoCs.

At first view using the label helps to have simpler dts files.

Is there any cons by using it?

I agree that converting the Marvell Armada 32-bits SoCs would produce a
lot of churn. But if some binding are common there is no file at all are
in common, so we could use this solution for the 64 bits SoCs only.

Jason, Andrew, Sebastian, do you see any problem with it?

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

From: camhirundo@gmail.com (Hirundo Cam)
Date: Wed, 4 May 2011 11:30:30 +0800
Subject: [PATCH] kirkwood: add dir-665 support
In-Reply-To: <20110503205056.GA13075@gentoodev.compulab.local>
References: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>
	<20110503205056.GA13075@gentoodev.compulab.local>
Message-ID: <BANLkTimtGMQC6yokSQ_cDAtcunzL8Pr_8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

>> +config MACH_MV88F6281_DIR665
>> + ? ? bool "Marvell 88F6281 DIR665 Board"
>> + ? ? help
>
> Citing checkpatch.pl:
> "WARNIING: please write a paragraph that describes the config symbol fully"

I've removed Kconfig and re-add the Kconfig in my git repo.
(rm is 1 commit, and the add is the following commit)
And then I've found most of those paragraph is this Kconfig has the
same problem.
So I have no idea where the problem is .

Regards,
Hirundo Cam

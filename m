From: mike@compulab.co.il (Mike Rapoport)
Date: Wed, 04 May 2011 09:31:25 +0300
Subject: [PATCH] kirkwood: add dir-665 support
In-Reply-To: <BANLkTimtGMQC6yokSQ_cDAtcunzL8Pr_8w@mail.gmail.com>
References: <1303922086-10531-1-git-send-email-camhirundo@gmail.com>	<20110503205056.GA13075@gentoodev.compulab.local>
	<BANLkTimtGMQC6yokSQ_cDAtcunzL8Pr_8w@mail.gmail.com>
Message-ID: <4DC0F2BD.4080806@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04/11 06:30, Hirundo Cam wrote:
> Hi Mike,
> 
>>> +config MACH_MV88F6281_DIR665
>>> +     bool "Marvell 88F6281 DIR665 Board"
>>> +     help
>>
>> Citing checkpatch.pl:
>> "WARNIING: please write a paragraph that describes the config symbol fully"
> 
> I've removed Kconfig and re-add the Kconfig in my git repo.
> (rm is 1 commit, and the add is the following commit)
> And then I've found most of those paragraph is this Kconfig has the
> same problem.
> So I have no idea where the problem is .

checkpatch.pl expects more elaborate description of the Kconfig option in the
help text and warns if such description can't be found. Since your description
is much the same as for other boards in arch/arm/mach-kirkwood, I suppose you
can ignore this warning.

> Regards,
> Hirundo Cam


-- 
Sincerely yours,
Mike.

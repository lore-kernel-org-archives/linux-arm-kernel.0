From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 08 Sep 2010 00:30:26 +0100
Subject: Cpufreq for s3c2440 FriendlyArm
In-Reply-To: <201009060540.19729.marek.vasut@gmail.com>
References: <AANLkTi=mvJywPgZbyGuNu46Ty5F3AkW2wBEa+Hu=skQq@mail.gmail.com>
	<201009060540.19729.marek.vasut@gmail.com>
Message-ID: <4C86CB12.5080701@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/09/10 04:40, Marek Vasut wrote:
> Dne Ne 5. z??? 2010 22:30:00 tarek attia napsal(a):
>> Hi all,
>>
>> Did anyone try the cpufreq on the mini2440 ? and did anyone get it
>> working on the board ?
>>
>> Each time I do the configuration in the kernel I found nothing on the
>> board ,however after the compilation I found the cpufreq.o & pll.o but
>> no file concerning that on the board .
>>
>>
>> Any help will be appreciated.
> 
> I believe you have the wrong mailing list here. LAK CCed.

linux-arm-kernel is the right one.

I've not tried on the mini2440, but it did work on other s3c2440
based machines. it may be there is a small bit of init missing
for the mini2440 to get the cpufreq running.

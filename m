From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Nov 2009 22:04:25 +0000
Subject: [PATCH 00/20] iPAQ h3100/h3600 work for 2.6.33
In-Reply-To: <4B103A34.8020308@gmx.com>
References: <1256414658-22611-1-git-send-email-mad_soft@inbox.ru>
	<20091024211026.GE16451@n2100.arm.linux.org.uk>
	<20091025153603.GA24490@rainbow> <20091115173048.GA19609@rainbow>
	<20091123203931.GI18142@n2100.arm.linux.org.uk>
	<20091124212541.GA5751@rainbow>
	<20091125165301.GC5136@n2100.arm.linux.org.uk>
	<4B0D6DD5.6090403@gmx.com>
	<20091125221113.GJ5136@n2100.arm.linux.org.uk>
	<4B103A34.8020308@gmx.com>
Message-ID: <20091127220425.GF28193@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2009 at 09:44:36PM +0100, Thomas Kunze wrote:
> Russell King - ARM Linux schrieb:
>> On Wed, Nov 25, 2009 at 06:48:05PM +0100, Thomas Kunze wrote:
>> Yes please.  I'd like to get all my outstanding branches sorted and
>> merged into the 'devel' stuff so it can sit in linux-next for a while
>> before the merge window.
>>   
> Please pull the for-lak branch at  
> git://git.linuxtogo.org/home/thesing/collie.git
> It contains the collie patches on top of 2.6.32-rc8 (see  
> http://git.linuxtogo.org/?p=thesing/collie.git;a=shortlog;h=refs/heads/for-lak)

In order to pull, I'd like to see at least a diffstat - you can get
this by:

git diff --stat origin...

assuming that you have an 'origin' branch which relates to Linus'
pristine kernel source.  This is so that I can confirm that I have
what you intended me to pull.

Even better would be to use something like git request-pull or something
which generates a substantially similar output.

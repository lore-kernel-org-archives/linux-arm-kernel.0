From: mchehab@redhat.com (Mauro Carvalho Chehab)
Date: Tue, 05 Apr 2011 15:29:19 -0300
Subject: [PATCH 00/34] Make kernel build deterministic
In-Reply-To: <1302027412.2924.7.camel@mulgrave.site>
References: <1302015561-21047-1-git-send-email-mmarek@suse.cz>	
	<20110405154918.GA31337@suse.de>
	<1302027412.2924.7.camel@mulgrave.site>
Message-ID: <4D9B5F7F.6090609@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em 05-04-2011 15:16, James Bottomley escreveu:
> On Tue, 2011-04-05 at 08:49 -0700, Greg KH wrote:
>> On Tue, Apr 05, 2011 at 04:58:47PM +0200, Michal Marek wrote:
>>>
>>> Hi,
>>>
>>> this series makes it possible to build bit-identical kernel image and
>>> modules from identical sources. Of course the build is already
>>> deterministic in terms of behavior of the code, but the various
>>> timestamps embedded in the object files make it hard to compare two
>>> builds, for instance to verify that a makefile cleanup didn't
>>> accidentally change something. A prime example is /proc/config.gz, which
>>> has both a timestamp in the gzip header and a timestamp in the payload
>>> data. With this series applied, a script like this will produce
>>> identical kernels each time:
>>
>> Very nice stuff.  Do you want to take the individual patches through one
>> of your trees, or do you mind if the subsystem maintainers take them
>> through theirs?
> 
> I'm happy for this to go through a single tree.

Me too.

With respect to the patches I was c/c (patches 13, 14, 31):

Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>

Thanks,
Mauro.

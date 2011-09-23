From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Fri, 23 Sep 2011 10:22:25 -0400
Subject: Identifying Primecells
In-Reply-To: <CAKON4OxHwjrw-dhH2qvXopqUqmKSx2TCPgW4eVHF9dmQO4=Cvw@mail.gmail.com>
References: <CAKON4OxqqBh4xFLwiMZzsGrnoG8erQ0hMFX-_VA-EDMvdNkvQQ@mail.gmail.com>
	<4E7C7FA2.30404@gmail.com>
	<CAKON4OzGEo+XvcNg=mzp3jhq3d3m7Z9bvZTSVCNLNjZ=KYbNBQ@mail.gmail.com>
	<4E7C89FC.4090209@gmail.com>
	<CAKON4OxZPFFL5NAgxLPRw2xxnS=v7iVWtQSSLcUJWfOYh4yfjA@mail.gmail.com>
	<1316787049.4611.920.camel@hornet.cambridge.arm.com>
	<CAKON4OxHwjrw-dhH2qvXopqUqmKSx2TCPgW4eVHF9dmQO4=Cvw@mail.gmail.com>
Message-ID: <CAKON4OySL81Hn6oHTOZuF7zkhwCMn3nn8T4GAgZySTVzxFHosA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 10:17 AM, jonsmirl at gmail.com <jonsmirl@gmail.com> wrote:
>>
>> Of course AMBA bus match_id will do this for you so, as I said, I'm not
>> sure what the problem is...

The problem is that I have a bunch of drivers for all of the
peripherals that were written by NXP. But the kernel has standardized
drivers for a lot of the primecells. If the LPC3130 has used a
standard primecell I want to get rid of the NXP supplied driver and
switch to the standard one.  But in order to do that I need to
identify the peripherals that are unmodified primecells.

-- 
Jon Smirl
jonsmirl at gmail.com

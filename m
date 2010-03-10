From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 10 Mar 2010 09:07:02 -0800
Subject: [PATCH 01/03] omap hsmmc: prevent race between dma and hsmmc
	callback
In-Reply-To: <618f0c911003100720n78ea2765l287631c85de1fe8@mail.gmail.com>
	(Venkatraman S.'s message of "Wed\, 10 Mar 2010 20\:50\:57 +0530")
References: <618f0c911003100611q42e7f23cuc3c8d3f116ca7eb3@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C46F13B4@dbde02.ent.ti.com>
	<618f0c911003100720n78ea2765l287631c85de1fe8@mail.gmail.com>
Message-ID: <87fx48gl6x.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Venkatraman S <svenkatr@ti.com> writes:

> Shilimkar, Santosh wrote:
>>> -----Original Message-----
>>> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of
>>> Venkatraman S
>>> Sent: Wednesday, March 10, 2010 7:42 PM
>>> To: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-mmc at vger.kernel.org
>>> Cc: Adrian Hunter; Chikkature Rajashekar, Madhusudhan; Tony Lindgren
>>> Subject: [PATCH 01/03] omap hsmmc: prevent race between dma and hsmmc callback
>>>
>>> See previous post http://patchwork.kernel.org/patch/82907/
>>> Rebased to 2.6.34-rc1 and fixed comment alignment.
>>>
>> Why did you dropped change log in all your patches? You should retain that and
>> just change the patch version in the subject.
>>
>
> My bad. I just edited the merge commit to point to the previous
> threads and posted it.
> Should I post them again ?
>

Yes.  

As Santosh pointed out, keep the changelog. and add any comments about
how this differs from previous versions after the '---' in the
changelog.

Keep in mind that the changelog will be stored in the git history and
should be useful without having to reference previous versions etc.

Anything useful to the reviewers but not important for the changelog
should go after the '---' since that will be ignored by git when
applying.

Kevin

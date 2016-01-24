From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Sun, 24 Jan 2016 22:38:57 +0000
Subject: [PATCH 03/15] dmaengine: dw: rename masters to reflect actual
 topology
In-Reply-To: <20160124223629.GI6588@sirena.org.uk> (Mark Brown's message of
 "Sun, 24 Jan 2016 22:36:29 +0000")
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-4-git-send-email-mans@mansr.com>
 <20160124223629.GI6588@sirena.org.uk>
Message-ID: <yw1xk2myli0u.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Sun, Jan 24, 2016 at 07:21:50PM +0000, Mans Rullgard wrote:
>> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> 
>> The source and destination masters are reflecting buses or their layers to
>> where the different devices can be connected. The patch changes the master
>> names to reflect which one is related to which independently on the transfer
>> direction.
>
> This is patch 3 of a series but I don't have anything else in the
> series.  What is going on with the rest of the series - what are the
> dependencies and so on?

I give up.  Seriously, this is impossible.  If I don't include everybody
in the slightest way related to any patch in the series, I get
complaints that patches are missing.  If I do, the lists reject it all
due to too many recipients.  What the hell am I supposed to do?

-- 
M?ns Rullg?rd

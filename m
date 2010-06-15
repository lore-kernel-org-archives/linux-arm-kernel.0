From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 15 Jun 2010 10:49:56 -0600
Subject: [PATCH 03/12] phylib: add a driver method for the SIOCSHWTSTAMP
	ioctl.
In-Reply-To: <20100615163409.GA10668@riccoc20.at.omicron.at>
References: <cover.1276615626.git.richard.cochran@omicron.at>
	<77fe18d640e35dcbfad1e117a4321f935500d5ac.1276615626.git.richard.cochran@omicron.at>
	<AANLkTiml5FyHstY-0ZPHxFDvA349BZv3TeX9gXtURFFN@mail.gmail.com>
	<20100615163409.GA10668@riccoc20.at.omicron.at>
Message-ID: <AANLkTilYe-TKxSnIweNt4laXLlhP6pCe9Hr4szqv_7TY@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 15, 2010 at 10:34 AM, Richard Cochran
<richardcochran@gmail.com> wrote:
> On Tue, Jun 15, 2010 at 10:27:59AM -0600, Grant Likely wrote:
>> On Tue, Jun 15, 2010 at 10:08 AM, Richard Cochran
>> <richardcochran@gmail.com> wrote:
>> > This patch adds a phy driver method for configuring hardware time stamping.
>> > Drivers may optionally implement this function.
>> >
>> > Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
>>
>> Adding an ioctl to the userspace ABI. ?Make sure you cc: linux-kernel
>> on the next spin of this series.
>
> Not sure what you mean. SIOCSHWTSTAMP is a standard socket option as
> of 2.6.30. The patch just makes it possible for PHY drivers to
> implement this option.

Ah, sorry.  I didn't go check that first.

g.

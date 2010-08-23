From: jason.mcmullan@netronome.com (Jason McMullan)
Date: Mon, 23 Aug 2010 15:51:25 -0400
Subject: Policy question: criteria for submission to mainline for a new
	SoC?
In-Reply-To: <20100823165317.GC20369@sirena.org.uk>
References: <AANLkTimpz2YVTqd1EVqoX3yKKQ-peAy=OgwEDmz-iVi-@mail.gmail.com>
	<201008231726.41399.marek.vasut@gmail.com>
	<AANLkTimzBeN2OzHkay5uNK1pK_w575NgAxJbcDmwYMby@mail.gmail.com>
	<20100823165317.GC20369@sirena.org.uk>
Message-ID: <AANLkTiknyv-sZeCDqaUq0LPx2ngRkba6jXggjduhg+_v@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 23, 2010 at 12:53 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>
> If you're doing this please make sure you provide a method for customers
> to customise the machine type (and get the rest of the boot protocol
> right).

Machine type (atag id) is one of the many customizable parameters.
I was itching to use Flattened Device Tree to hold these parameters,
but as far as I can tell that 'isn't ready for prime time' on ARM at
the moment.

--
Jason S. McMullan
Netronome Systems, Inc.

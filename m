From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 Mar 2011 13:18:28 +0000
Subject: [RFC PATCHv1 1/2] Export SoC info through sysfs
In-Reply-To: <4D78A0CC.1030705@stericsson.com>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<1299689961-5028-2-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<20110309174752.GC1225@sirena.org.uk>
	<4D78A0CC.1030705@stericsson.com>
Message-ID: <20110310131828.GA7411@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 10:58:36AM +0100, Maxime Coquelin wrote:
> On 03/09/2011 06:47 PM, Mark Brown wrote:

>> Would it not be better for this to depend on a symbol that systems can
>> select when they add useful output?  If there's nothing that generates
>> information for it on a given platform there's no point in enabling it.

> It is deactivated by default when "default" parameter is not mentioned.

That's not the point - if the user sees the option and turns it on then
there won't be anything they can actually do with it unless some other
bit of software creates some data.  No sense in offering them an option
they can't actually use.

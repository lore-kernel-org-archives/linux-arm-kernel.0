From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 8 Dec 2010 23:16:34 +0000
Subject: [PATCH 2/3] ASoC: CS4271 codec support
In-Reply-To: <1291849166.31916.74.camel@r60e>
	(sfid-20101208_225932_331499_3B362103)
References: <1291809772.31916.4.camel@r60e>
	<20101208130558.GE16418@rakim.wolfsonmicro.main>
	<1291849166.31916.74.camel@r60e>
	(sfid-20101208_225932_331499_3B362103)
Message-ID: <AB4B79E7-D4CF-4098-83C9-708C1EDBE26F@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 Dec 2010, at 22:59, Alexander wrote:

> On Wed, 2010-12-08 at 13:05 +0000, Mark Brown wrote:

>> Ideally the deemphasis would be managed based on the sample rate.

> I'm not sure if it's necessary feature at all. And the way it should be
> managed is something unclear to me )

Provide the user with an on/off switch then if enabled select the deemphasis
filter which is closest to the sample rate. It's not essential to provide the control
but you may as well.

From: stefan@agner.ch (Stefan Agner)
Date: Fri, 06 Dec 2013 15:57:14 +0100
Subject: [PATCH v5 2/3] regulator: tps6586x: add and use correct voltage
 table
In-Reply-To: <20131206125502.GF29268@sirena.org.uk>
References: <cover.1386333697.git.stefan@agner.ch>
 <7c948660cda4684d28fa97f82295ab84f6ef658e.1386333697.git.stefan@agner.ch>
 <20131206125502.GF29268@sirena.org.uk>
Message-ID: <102f036079d68c84b87ec30a6566bb21@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2013-12-06 13:55, schrieb Mark Brown:
> On Fri, Dec 06, 2013 at 01:51:46PM +0100, Stefan Agner wrote:
>> Depending on the regulator version, the voltage table might be
>> different. Use version specific regulator tables in order to select
>> correct voltage table. For the following regulator versions different
>> voltage tables are now used:
> 
> I think this is the same as the last patch I reviewed but I don't see my
> ack on it?

Oh sorry, its my first multi-revision submission. I didn't realized that
it is my job to add them when doing a new revision... Lee, can you add
that when you apply the patch? So far I see

Acked-by: Mark Brown <broonie@linaro.org>
Reviewed-by: Thierry Reding <treding@nvidia.com>

for this patch.

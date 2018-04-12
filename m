From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 12 Apr 2018 18:55:28 +0200
Subject: [PATCH 08/15] ASoC: pxa: remove the dmaengine compat need
In-Reply-To: <20180412152632.GG9929@sirena.org.uk> (Mark Brown's message of
 "Thu, 12 Apr 2018 16:26:32 +0100")
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
 <20180402142656.26815-9-robert.jarzmik@free.fr>
 <20180412152632.GG9929@sirena.org.uk>
Message-ID: <87a7u82wlb.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Mon, Apr 02, 2018 at 04:26:49PM +0200, Robert Jarzmik wrote:
>> As the pxa architecture switched towards the dmaengine slave map, the
>> old compatibility mechanism to acquire the dma requestor line number and
>> priority are not needed anymore.
>
> Acked-by: Mark Brown <broonie@kernel.org>
>
> If there's no dependency I'm happy to take this for 4.18.
Thanks for the ack.

The patches 1 and 2 are the dependency here, so I'd rather push it through my
tree once the review is complete.

Cheers.

-- 
Robert
